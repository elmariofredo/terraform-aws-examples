locals {
  domain_prefix = "great_moravia"
}

module "great_moravia" {
  source = "./env/great_moravia"

  domain_prefix = local.domain_prefix
  parent_dns_zone = aws_route53_zone.main
}


