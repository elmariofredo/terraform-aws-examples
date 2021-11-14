resource "random_password" "main" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "rancher2_user" "main" {
  name     = var.name
  username = var.username
  password = random_password.main.result
  enabled  = var.enabled
}

resource "rancher2_global_role_binding" "main" {
  global_role_id = var.global_role_id
  user_id        = rancher2_user.main.id
}
