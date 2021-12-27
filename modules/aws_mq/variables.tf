variable "name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "mq.t3.micro"
}

variable "engine_type" {
  type = string
  default = "RabbitMQ"
}

variable "engine_version" {
  type = string
  default = "3.8.22"
}

variable "user" {
  type = string
  default = "admin"
}
