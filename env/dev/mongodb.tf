module "aws_mongodb" {
  source = "../../modules/aws_mongodb"

  name                = local.name
}

output "mongodb_endpoint" {
  value = module.aws_mongodb.endpoint
}

output "mongodb_user" {
  value = module.aws_mongodb.user
}

output "mongodb_password" {
  value = module.aws_mongodb.password
}

output "mongodb_port" {
  value = module.aws_mongodb.port
}
