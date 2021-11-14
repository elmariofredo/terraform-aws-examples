variable "rancher_domain" {
  type = string
}

variable "tls" {
  type    = string
  default = "ingress"
}

variable "letsencrypt_email" {
  type = string
}

variable "ingress_class" {
  type = string
}

variable "values" {
  type    = map(any)
  default = {}
}

variable "bootstrap_password" {
  type = string
}
