resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager-system"
  create_namespace = "true"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.6.1"


  set {
    name  = "installCRDs"
    value = true
  }
}

locals {
  letsencrypt_issuer = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt"
    }
    spec : {
      acme : {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.letsencrypt_email
        privateKeySecretRef = {
          name = "letsencrypt"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = var.ingress_class
                # ingressTemplate = {
                #   metadata = {
                #     annotations = {
                #       "kubernetes.io/ingress.class" = var.ingress_class
                #     }
                #   }
                # }
              }
            }
        }]
      }
    }
  }
}

# NOTE: Unable to use kubernetes_manifest because of https://github.com/hashicorp/terraform-provider-kubernetes/issues/1391
resource "kubectl_manifest" "letsencrypt_issuer" {

  yaml_body = yamlencode(local.letsencrypt_issuer)

  depends_on = [
    helm_release.cert_manager
  ]

}
