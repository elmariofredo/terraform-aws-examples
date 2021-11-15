variable "name" {
  type = string
}

variable "node_group_desired" {
  type = number
  default = 1
}

variable "node_group_min" {
  type = number
  default = 1
}

variable "node_group_max" {
  type = number
  default = 1
}

variable "node_group_max_unavailable" {
  type = number
  default = 1
}

variable "node_group_instance_types" {
  type = list(string)
  default = ["t3.medium"] # See https://calculator.aws/#/createCalculator/EC2
}


