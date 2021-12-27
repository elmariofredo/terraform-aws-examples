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
  # See https://github.com/aws/amazon-vpc-cni-k8s/blob/master/pkg/awsutils/vpc_ip_resource_limit.go#L21
  # and https://instances.vantage.sh
  # and https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
  default = ["t3.medium"]
}


