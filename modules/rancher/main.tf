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
      tls      = var.tls
      hostname = var.rancher_domain
      ingress = {
        # extraAnnotations = {
          # "kubernetes.io/ingress.class" = var.ingress_class
          # "cert-manager.io/cluster-issuer"= "letsencrypt"
          # "projectcontour.io/websocket-routes" = "/"
        # }
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
      features = "fleet=false,continuous-delivery=false,istio-virtual-service-ui=false" # https://github.com/rancher/rancher/blob/release/v2.6/pkg/features/feature.go#L20-L104
      bootstrapPassword = var.bootstrap_password
    }),
    yamlencode(var.values)
  ]

}
