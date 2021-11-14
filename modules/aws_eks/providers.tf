provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://${local.rancher_domain}"
  # TODO: resolve cert manager issues
  # insecure = true
  bootstrap = true
}

provider "rancher2" {
  alias = "main"

  api_url = rancher2_bootstrap.main.url
  token_key = rancher2_bootstrap.main.token

  # api_url   = "https://${local.rancher_domain}"

  # TODO: resolve cert manager issues
  # insecure = true
  # token_key = rancher2_bootstrap.rancher_token_key

  timeout = "120s"
}

provider "helm" {
  kubernetes {
    config_path = local.kube_config_path
  }
}

provider "kubernetes" {
  config_path = local.kube_config_path
}

provider "kubectl" {
  config_path = local.kube_config_path
}
