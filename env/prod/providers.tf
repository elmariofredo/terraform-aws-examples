
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
