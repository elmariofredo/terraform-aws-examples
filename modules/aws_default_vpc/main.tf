resource "aws_default_vpc" "default" {}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

