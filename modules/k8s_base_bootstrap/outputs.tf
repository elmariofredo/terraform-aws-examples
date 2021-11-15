output "lb_hostname" {
  value = module.ingress_nginx.lb_hostname
}

output "modules" {
  value = [
    module.ingress_nginx,
    module.cert_manager
  ]
  description = "Output modules to allow dependency check see https://github.com/hashicorp/terraform/issues/28580#issuecomment-831263879"
}

output "ready" {
  value = module.cert_manager
}
