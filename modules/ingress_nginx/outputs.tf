output "lb_hostname" {
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.hostname
}
