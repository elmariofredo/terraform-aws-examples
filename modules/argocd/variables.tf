variable "name" {
  default = "argocd"
  type    = string
}

variable "argocd_domain" {
  type = string
}

variable "namespace" {
  default = "argocd-system"
  type    = string
}

variable "values" {
  type    = string
  default = ""
}

variable "ingress_class" {
  type    = string
  default = "nginx"
}

variable "credentialTemplates" {
  type    = map
  default = {}
}
