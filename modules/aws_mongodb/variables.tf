variable "name" {
  type = string
}

variable "user" {
  type = string
  default = "docdb"
}

variable "instance_class" {
  type = string
  default = "db.t3.medium"
}

variable "engine" {
  type = string
  default = "docdb"
}

variable "engine_version" {
  type = string
  default = "4.0.0"
}
