output "rancher_url" {
  value = module.k8s_base.rancher_url
}

output "rancher_user" {
  value = module.k8s_base.rancher_user
}

output "rancher_password" {
  value = module.k8s_base.rancher_password
  sensitive = true
}

output "argo_url" {
  value = module.k8s_base.argo_url
}

output "argo_user" {
  value = module.k8s_base.argo_user
}

output "argo_password" {
  value = module.k8s_base.argo_password
  sensitive = true
}
