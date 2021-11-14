output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "rancher_url" {
  value = module.rancher.url
}

output "rancher_user" {
  value = "admin" #module.rancher2_bootstrap.user
}

output "rancher_password" {
  value = random_password.password.result
}

output "argo_url" {
  value = module.argocd.url
}

output "argo_password" {
  value = module.argocd.password
  sensitive = true
}
