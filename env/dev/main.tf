locals {
  name          = "dev"
  domain        = "k8s.vejlupek.online"
  nodes_desired = 2
  nodes_max     = 2
}

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

# resource "null_resource" "k8s_base_bootstrap_check_dependency" {
#   state = true

#   depends_on = [
#     module.k8s_base_bootstrap
#   ]
# }

module "k8s_base" {
  source = "../../modules/k8s_base"

  name              = local.name
  domain            = local.domain
  letsencrypt_email = var.email

  # dependency_check = null_resource.state
  depends_on_check = module.k8s_base_bootstrap.ready

}

