variable "namespace" {
  default = "ingress-nginx-system"
  type    = string
}

variable "controller_ingress_class" {
  default = "nginx"
  type    = string
}

variable "controller_metrics_enabled" {
  default = false
  type    = bool
}

variable "controller_metrics_serviceMonitor_enabled" {
  default = false
  type    = bool
}

variable "controller_hostports_http" {
  default = 80
  type    = number
}

variable "controller_hostports_https" {
  default = 443
  type    = number
}

variable "values" {
  type = map
  description = "helm chart values override"
  default = {}
}
