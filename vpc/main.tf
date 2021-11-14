data "aws_vpc" "main" {
  id = var.id
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.id]
  }
}
