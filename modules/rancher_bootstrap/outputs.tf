output "rancher_api_url" {
  value = rancher2_bootstrap.main.url
}

output "user" {
  value = var.user
}

output "rancher_token_key" {
  value     = rancher2_bootstrap.main.token
  sensitive = true
}

output "rancher_password" {
  value     = random_password.password.result
  sensitive = true
}
