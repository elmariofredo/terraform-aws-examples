resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "rancher2_bootstrap" "main" {
  # user = var.user TODO enable
  password = random_password.password.result
  provider = rancher2.bootstrap
}

