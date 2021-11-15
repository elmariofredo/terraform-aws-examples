
locals {
  kube_config_path = "tmp/${var.name}-kubeconfig.yml"
#   domain_suffix    = "${var.name}.${var.domain}"
#   rancher_domain   = "rancher.${local.domain_suffix}"
}

module "aws_default_vpc" {
  source = "../../modules/aws_default_vpc"
}

# https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html
resource "aws_eks_cluster" "main" {
  name     = var.name
  role_arn = aws_iam_role.main.arn

  vpc_config {
    subnet_ids = module.aws_default_vpc.subnet_ids
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
  subnet_ids      = module.aws_default_vpc.subnet_ids
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

}
