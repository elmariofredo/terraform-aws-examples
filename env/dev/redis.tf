module "aws_redis" {
  source = "../../modules/aws_redis"

  name                = local.name
}

output "redis_endpoint" {
  value = module.aws_redis.endpoint
}
