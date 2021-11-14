variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list
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

variable "lb_service_account_name" {
  type        = string
  default     = "aws-lb-ingress-controller"
  description = "The Kubernetes service account name"
}

variable "lb_values" {
  type        = map(any)
  default     = {}
  description = "Helm chart values, see https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller#configuration."
}

variable "letsencrypt_email" {
  type = string
}

variable "domain" {
  type = string
}
