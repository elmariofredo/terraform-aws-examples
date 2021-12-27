variable "name" {
  type = string
}

variable "user" {
  type = string
  default = "admin"
}

variable "instance_class" {
  type = string
  default = "db.r4.large"
}

variable "engine" {
  type = string
  default = "aurora-mysql"
}

variable "engine_version" {
  type = string
  default = "5.7.mysql_aurora.2.10.1"
}

variable "publicly_accessible" {
  type = bool
  default = false
}
