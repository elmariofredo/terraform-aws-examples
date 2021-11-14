resource "random_password" "main" {
  length  = 16
  special = true
}

resource "helm_release" "main" {
  name             = var.name
  version          = "3.21.0"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  namespace        = var.namespace
  create_namespace = true
  atomic           = true

  # https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml

  values = [
    yamlencode({
      server = {
        extraArgs = [
          "--insecure"
        ]
        config = {
          url = "https://${var.argocd_domain}"
        }

        ingress = {
          enabled          = true
          ingressClassName = "${var.ingress_class}"
          hosts = [
            var.argocd_domain
          ]
          annotations = {
            "cert-manager.io/cluster-issuer" : "letsencrypt"
          }
          tls = [
            {
              hosts = [
                var.argocd_domain
              ]
              secretName = "argocd-tls-certificate"
            }
          ]
        }
      }
      configs = {
        secret = {
          argocdServerAdminPassword      = bcrypt(random_password.main.result)
          argocdServerAdminPasswordMtime = timestamp()
        }
        credentialTemplates = var.credentialTemplates
      }
      controller = {
        enableStatefulSet = true
      }
      installCRDs = true
    }),
    var.values
  ]

}
