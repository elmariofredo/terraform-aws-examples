variable "name" {
  type = string
}

variable "number_cache_clusters" {
  type = number
  default = 2
}

variable "instance_type" {
  type = string
  default = "cache.m4.large"
}

variable "engine" {
  type = string
  default = "docdb"
}

# variable "parameter_group_name" {
#   type = string
#   default = "default.redis3.2"
# }

variable "family" {
  type = string
  default = "redis6.x"
}
