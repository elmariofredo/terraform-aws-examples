output "user" {
  value     = local.user
}

output "password" {
  value     = random_password.main.result
  sensitive = true
}

output "url" {
  value     = "https://${var.argocd_domain}"
}
