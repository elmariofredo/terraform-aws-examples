module "aws_elasticsearch" {
  source = "../../modules/aws_elasticsearch"

  name = local.name
}

output "elasticsearch_endpoint" {
  value = module.aws_elasticsearch.endpoint
}
