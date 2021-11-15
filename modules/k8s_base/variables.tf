variable "name" {
  type = string
}
variable "letsencrypt_email" {
  type = string
}

variable "domain" {
  type = string
}

variable "ingress_class" {
  type    = string
  default = "nginx"
}

variable "depends_on_check" {
  type        = any
  description = "Verify that dependencies necessary for installation are ready see https://github.com/hashicorp/terraform/issues/28580#issuecomment-831263879"
}
