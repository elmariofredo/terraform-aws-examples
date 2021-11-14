
locals {
  kube_config_path = "tmp/${var.name}-kubeconfig.yml"
  ingress_class    = "nginx"
  domain_suffix    = "${var.name}.${var.domain}"
  rancher_domain   = "rancher.${local.domain_suffix}"
}

# https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html
resource "aws_eks_cluster" "main" {
  name     = var.name
  role_arn = aws_iam_role.main.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.main-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.main-AmazonEKSVPCResourceController,
  ]

}


resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "main"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.node_group_instance_types

  scaling_config {
    desired_size = var.node_group_desired
    max_size     = var.node_group_max
    min_size     = var.node_group_min
  }

  update_config {
    max_unavailable = var.node_group_max_unavailable
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node_group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "local_file" "kube_config" {
  content = yamlencode({
    "apiVersion" = "v1"

    "clusters" = [{
      "cluster" = {
        "certificate-authority-data" = "${aws_eks_cluster.main.certificate_authority[0].data}"

        "server" = "${aws_eks_cluster.main.endpoint}"
      }

      "name" = "kubernetes"
    }]

    "contexts" = [{
      "context" = {
        "cluster" = "kubernetes"

        "user" = "aws"
      }

      "name" = "aws"
    }]

    "current-context" = "aws"

    "kind" = "Config"

    "preferences" = {}

    "users" = [{
      "name" = "aws"
      "user" = {
        "exec" = {
          "apiVersion" = "client.authentication.k8s.io/v1alpha1"

          "args" = ["eks", "get-token", "--cluster-name", "${var.name}"]

          "command" = "aws"
        }
      }
    }]
  })
  filename = local.kube_config_path

  depends_on = [
    aws_eks_node_group.main,
  ]
}

# data "tls_certificate" "main" {
#   url = aws_eks_cluster.main.identity[0].oidc[0].issuer
# }

# resource "aws_iam_openid_connect_provider" "main" {
#   url            = aws_eks_cluster.main.identity[0].oidc[0].issuer
#   client_id_list = ["sts.amazonaws.com"]
#   thumbprint_list = [
#     data.tls_certificate.main.certificates.0.sha1_fingerprint
#   ]
# }

module "ingress_nginx" {
  source                   = "../../modules/ingress_nginx"
  controller_ingress_class = local.ingress_class

  depends_on = [
    # aws_iam_openid_connect_provider.main,
    # helm_release.lb_controller,
    # aws_eks_cluster.main
    local_file.kube_config,
  ]
}

module "k8s_dns" {
  source = "../../modules/k8s_dns"

  domain                        = var.domain
  instance_name                 = var.name
  ingress_loadbalancer_hostname = module.ingress_nginx.lb_hostname
}

module "cert_manager" {
  source = "../../modules/cert_manager"

  # kube_config_path  = local.kube_config_path
  letsencrypt_email = var.letsencrypt_email
  ingress_class     = local.ingress_class

  depends_on = [
    module.k8s_dns,
    module.ingress_nginx,
  ]

}


resource "random_password" "rancher_bootstrap_password" {
  length           = 16
  special          = true
  override_special = "_"
}

module "rancher" {
  source             = "../../modules/rancher"
  rancher_domain     = local.rancher_domain
  letsencrypt_email  = var.letsencrypt_email
  ingress_class      = local.ingress_class
  bootstrap_password = random_password.rancher_bootstrap_password.result

  depends_on = [
    module.cert_manager
  ]
}

# TODO: rename to rancher_bootsrap_password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "rancher2_bootstrap" "main" {
  initial_password = random_password.rancher_bootstrap_password.result
  password         = random_password.password.result
  provider         = rancher2.bootstrap

  depends_on = [
    module.rancher,
  ]
}

module "argocd" {
  source = "../../modules/argocd"

  argocd_domain = "argocd.${local.domain_suffix}"
  ingress_class = local.ingress_class

  depends_on = [
    module.ingress_nginx,
  ]
}

module "rancher_monitoring_local" {
  source = "../../modules/rancher_monitoring"

  cluster_id = "local"

  providers = {
    rancher2 = rancher2.main
  }

  depends_on = [
    rancher2_bootstrap.main,
  ]
}

module "sealed_secrets" {
  source = "../../modules/sealed_secrets"

  depends_on = [
    module.ingress_nginx,
  ]
}
