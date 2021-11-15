output "rancher_url" {
  value = "https://${local.rancher_domain}"
}

output "rancher_user" {
  value = rancher2_bootstrap.main.user
}

output "rancher_password" {
  value = random_password.rancher_admin_password.result
}

output "argo_url" {
  value = module.argocd.url
}

output "argo_password" {
  value = module.argocd.password
  sensitive = true
}

output "argo_user" {
  value = module.argocd.user
}
