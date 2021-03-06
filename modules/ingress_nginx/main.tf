resource "helm_release" "ingress" {
  name             = "ingress-nginx"
  namespace        = var.namespace
  create_namespace = "true"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.6"

  // Values: https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml

  values = [
    yamlencode({
      hostPort = {
        enabled = true
      }
      controller = {
        kind         = "Deployment"
        ingressClass = var.controller_ingress_class
        service = {
          type = "LoadBalancer"
        }
        metrics = {
          enabled = var.controller_metrics_enabled
          serviceMonitor = {
            enabled = var.controller_metrics_serviceMonitor_enabled
          }
        }
        ingressClassResource = {
          enabled = true
          default = true
        }
        service = {
          # externalTrafficPolicy = "Local" https://github.com/kubernetes/ingress-nginx/issues/6263
          annotations = {
            "service.beta.kubernetes.io/aws-load-balancer-proxy-protocol" = "*"
          }
        }
        config = {
          "use-proxy-protocol": "true"
          "forwarded-for-header": "true"
        }
      }
    }),
    yamlencode(var.values)
  ]
}

data "kubernetes_service" "ingress" {
  metadata {
    name = "ingress-nginx-controller"
    namespace = var.namespace
  }

  depends_on = [
    helm_release.ingress
  ]
}


