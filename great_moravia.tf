locals {
  name = "great_moravia"
}

module "great_moravia" {
  source = "./env/great_moravia"

  name = local.name
  parent_dns_zone = aws_route53_zone.main
}


