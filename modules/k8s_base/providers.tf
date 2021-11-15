provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://${local.rancher_domain}"
  bootstrap = true
}

provider "rancher2" {
  alias = "main"

  api_url   = rancher2_bootstrap.main.url
  token_key = rancher2_bootstrap.main.token
  timeout   = "120s"
}
