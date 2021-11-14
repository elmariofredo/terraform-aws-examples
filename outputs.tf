# # Outputs
# output "eks_endpoint" {
#   value = module.eks.endpoint
# }

# output "eks_kubeconfig-certificate-authority-data" {
#   value = module.eks.kubeconfig-certificate-authority-data
# }

output "mgmt_rancher_url" {
  value = module.eks-mgmt.rancher_url
}

output "mgmt_rancher_user" {
  value = module.eks-mgmt.rancher_user
}

output "mgmt_rancher_password" {
  value = module.eks-mgmt.rancher_password
  sensitive = true
}

output "mgmt_rancher_password_extract" {
  value = "terraform output -json | jq -r .mgmt_rancher_password.value"
}

output "mgmt_argo_url" {
  value = module.eks-mgmt.argo_url
}

output "mgmt_argo_password" {
  value = module.eks-mgmt.argo_password
  sensitive = true
}

output "mgmt_argo_password_extract" {
  value = "terraform output -json | jq -r .mgmt_argo_password.value"
}
