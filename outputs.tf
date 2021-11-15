output "dev_rancher_url" {
  value = module.dev.rancher_url
}

output "dev_rancher_user" {
  value = module.dev.rancher_user
}

output "dev_rancher_password" {
  value = module.dev.rancher_password
  sensitive = true
}

output "dev_rancher_password_extract" {
  value = "terraform output -json | jq -r .dev_rancher_password.value"
}

output "dev_argo_url" {
  value = module.dev.argo_url
}

output "dev_argo_user" {
  value = module.dev.argo_user
  sensitive = true
}
output "dev_argo_password" {
  value = module.dev.argo_password
  sensitive = true
}

output "dev_argo_password_extract" {
  value = "terraform output -json | jq -r .dev_argo_password.value"
}
