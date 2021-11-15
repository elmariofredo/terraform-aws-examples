
locals {
  kube_config_path = "tmp/${var.name}-kubeconfig.yml"
  ingress_class    = "nginx"
  domain_suffix    = "${var.name}.${var.domain}"
  rancher_domain   = "rancher.${local.domain_suffix}"
}

module "ingress_nginx" {
  source                   = "../../modules/ingress_nginx"
  controller_ingress_class = local.ingress_class
}


module "cert_manager" {
  source = "../../modules/cert_manager"

  letsencrypt_email = var.letsencrypt_email
  ingress_class     = local.ingress_class

  depends_on = [
    module.ingress_nginx
  ]
}
