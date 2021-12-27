variable "name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "r4.large.elasticsearch"
}

variable "engine_version" {
  type = string
  default = "7.10"
}

variable "volume_size" {
  type = number
  default = 10
}

