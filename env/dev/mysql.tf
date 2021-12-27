module "aws_aurora_mysql" {
  source = "../../modules/aws_aurora"

  name                = local.name
  publicly_accessible = true
}

output "db_endpoint" {
  value = module.aws_aurora_mysql.endpoint
}

output "db_user" {
  value = module.aws_aurora_mysql.user
}

output "db_password" {
  value = module.aws_aurora_mysql.password
}

output "db_port" {
  value = module.aws_aurora_mysql.port
}

