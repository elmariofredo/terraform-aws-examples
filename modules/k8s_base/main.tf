locals {
  kube_config_path = "tmp/${var.name}-kubeconfig.yml"
  # ingress_class    = "nginx"
  domain_suffix  = "${var.name}.${var.domain}"
  rancher_domain = "rancher.${local.domain_suffix}"
}

resource "random_password" "rancher_bootstrap_password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "helm_release" "rancher" {
  name             = "rancher"
  namespace        = "cattle-system"
  create_namespace = true
  repository       = "https://releases.rancher.com/server-charts/latest"
  chart            = "rancher"
  version          = "2.6.2"

  # TODO
  # See https://github.com/rancher/rancher/blob/release/v2.6/chart/values.yaml
  values = [
    yamlencode({
      tls      = "ingress"
      hostname = local.rancher_domain
      ingress = {
        tls = {
          source = "letsEncrypt"
        }
      }
      letsEncrypt = {
        email = var.letsencrypt_email
        ingress = {
          class = var.ingress_class
        }
      }
      features          = "fleet=false,continuous-delivery=false,istio-virtual-service-ui=false" # https://github.com/rancher/rancher/blob/release/v2.6/pkg/features/feature.go#L20-L104
      bootstrapPassword = random_password.rancher_bootstrap_password.result
    })
  ]

  depends_on = [var.depends_on_check]

}

resource "random_password" "rancher_admin_password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "rancher2_bootstrap" "main" {
  initial_password = random_password.rancher_bootstrap_password.result
  password         = random_password.rancher_admin_password.result
  provider         = rancher2.bootstrap

  depends_on = [
    helm_release.rancher,
  ]
}

module "rancher_monitoring_local" {
  source = "../../modules/rancher_monitoring"

  cluster_id = "local"

  providers = {
    rancher2 = rancher2.main
  }

  depends_on = [
    rancher2_bootstrap.main,
  ]
}

module "argocd" {
  source = "../../modules/argocd"

  argocd_domain = "argocd.${local.domain_suffix}"
  ingress_class = var.ingress_class

}
