variable "letsencrypt_email" {
  type = string
}

variable "ingress_class" {
  type = string
  default = "nginx"
}
