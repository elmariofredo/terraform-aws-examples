module "aws_eks" {
  source = "../../modules/aws_eks"

  name               = local.name
  node_group_max     = local.nodes_max
  node_group_desired = local.nodes_desired

}

module "k8s_base_bootstrap" {
  source = "../../modules/k8s_base_bootstrap"

  name              = local.name
  domain            = local.domain
  letsencrypt_email = var.email

  depends_on = [
    module.aws_eks
  ]
}


module "k8s_dns" {
  source = "../../modules/k8s_dns"

  domain                        = local.domain
  instance_name                 = local.name
  ingress_loadbalancer_hostname = module.k8s_base_bootstrap.lb_hostname
}

module "k8s_base" {
  source = "../../modules/k8s_base"

  name              = local.name
  domain            = local.domain
  letsencrypt_email = var.email

  # dependency_check = null_resource.state
  depends_on_check = module.k8s_base_bootstrap.ready

}

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
