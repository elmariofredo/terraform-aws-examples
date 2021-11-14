locals {
  letsencrypt_email = "accounts-infra@sikalabs.com"
  vpc_id            = "vpc-5eb2d334"
}

# module "route53" {
#   source = "./route53"
# }

module "vpc" {
  source = "./vpc"

  id = local.vpc_id
}

module "eks-mgmt" {
  source = "./modules/aws_eks"

  name               = "mgmt-purple"
  letsencrypt_email  = local.letsencrypt_email
  domain             = "k8s.vejlupek.online"
  node_group_max     = 2
  node_group_desired = 2

  subnet_ids = module.vpc.subnet_ids
}




# module "lb-controller" {
#   source       = "../../modules/lb-controller"
#   enabled      = module.eks.features.managed_node_groups_enabled || module.eks.features.node_groups_enabled
#   cluster_name = module.eks.cluster.name
#   oidc         = module.eks.oidc
#   tags         = var.tags
# }

# module "ingress_nginx" {
#   source = "modules/ingress_nginx"

#   depends_on = [
#     module.eks-mgmt # Loadbalancer needs to be setup first
#   ]
# }

# module "contour" {
#   source                   = "../../modules/contour"
#   count                    = local.config.ingress == "contour" ? 1 : 0
#   controller_ingress_class = local.ingress_class

#   depends_on = [
#     module.rke # Loadbalancer needs to be setup first
#   ]
# }


# module "cert_manager" {
#   source = "../../modules/cert_manager"

#   letsencrypt_email = local.config.letsencrypt_email
#   ingress_class     = local.ingress_class

#   depends_on = [
#     module.rke,
#     module.cilium,
#   ]

# }


# module "rancher" {
#   source            = "../../modules/rancher"
#   rancher_domain    = local.rancher_domain
#   letsencrypt_email = local.config.letsencrypt_email
#   ingress_class     = local.ingress_class

#   depends_on = [
#     module.rke,
#     module.cert_manager,
#     module.ingress_nginx,
#     module.contour,
#   ]
# }

# module "rancher_bootstrap" {
#   source          = "../../modules/rancher_bootstrap"
#   rancher_api_url = "https://${local.rancher_domain}"

#   providers = {
#     rancher2 = rancher2.bootstrap
#   }

#   depends_on = [
#     module.rancher,
#   ]
# }

# module "rancher_user_rancher" {
#   source = "../../modules/rancher_user"

#   name           = "rancher"
#   username       = "rancher"
#   global_role_id = "admin"

#   providers = {
#     rancher2 = rancher2.main
#   }

#   depends_on = [
#     module.rancher_bootstrap,
#   ]
# }

# module "argocd" {
#   source = "../../modules/argocd"

#   argocd_domain = "argocd.${local.domain_suffix}"
#   ingress_class = local.ingress_class

#   depends_on = [
#     module.ingress_nginx,
#   ]
# }


# module "rancher_monitoring_local" {
#   source = "../../modules/rancher_monitoring"

#   cluster_id = "local"

#   providers = {
#     rancher2 = rancher2.main
#   }

#   depends_on = [
#     module.rancher_bootstrap,
#   ]
# }

# module "sealed_secrets" {
#   source = "../../modules/sealed_secrets"

#   depends_on = [
#     module.rke,
#   ]
# }


# module "s3-audited" {
#   source = "./s3-audited"
# }

# module "sso" {
#   source = "./sso"
# }
