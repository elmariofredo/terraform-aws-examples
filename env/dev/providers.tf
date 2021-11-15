# provider "rancher2" {
#   alias = "bootstrap"

#   api_url   = "https://${local.rancher_domain}"
#   bootstrap = true
# }

# provider "rancher2" {
#   alias = "main"

#   api_url   = rancher2_bootstrap.main.url
#   token_key = rancher2_bootstrap.main.token
#   timeout   = "120s"
# }


provider "kubernetes" {
  host                   = module.aws_eks.endpoint
  cluster_ca_certificate = base64decode(module.aws_eks.kubeconfig-certificate-authority-data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", local.name]
    command     = "aws"
  }
}

provider "kubectl" {
  host                   = module.aws_eks.endpoint
  cluster_ca_certificate = base64decode(module.aws_eks.kubeconfig-certificate-authority-data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", local.name]
    command     = "aws"
  }

}

provider "helm" {
  kubernetes {
    host                   = module.aws_eks.endpoint
    cluster_ca_certificate = base64decode(module.aws_eks.kubeconfig-certificate-authority-data)

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", local.name]
      command     = "aws"
    }
  }
}
