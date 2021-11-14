provider "rancher2" {
  alias = "bootstrap"

  api_url   = "https://${var.rancher_api_url}"
  bootstrap = true
}
