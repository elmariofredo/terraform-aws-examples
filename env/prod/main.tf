locals {
  name          = "prod"
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

}

