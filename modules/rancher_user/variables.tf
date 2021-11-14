variable "name" {
  type = string
}

variable "username" {
  type = string
}

variable "enabled" {
  default = true
  type    = bool
}

variable "global_role_id" {
  default = "user"
  type    = string
}
