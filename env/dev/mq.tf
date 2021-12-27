module "aws_mq" {
  source = "../../modules/aws_mq"

  name                = local.name
}

output "mq_endpoint" {
  value = module.aws_mq.endpoint
}

output "mq_user" {
  value = module.aws_mq.user
}

output "mq_password" {
  value = module.aws_mq.password
}


