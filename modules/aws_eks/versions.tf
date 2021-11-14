terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.2.4"
    }
    rancher2 = {
      source                = "rancher/rancher2"
      version               = "1.21.0"
      configuration_aliases = [rancher2.bootstrap, rancher2.main]
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.6.1"
    }
  }
  required_version = ">= 1.0.0"
}
