locals {
  email = "accounts-infra@sikalabs.com"
  # vpc_id            = "vpc-5eb2d334"
}

# module "route53" {
#   source = "./route53"
# }

# module "vpc" {
#   source = "./vpc"

#   id = local.vpc_id
# }

module "dev" {
  source = "./env/dev"

  email = local.email
}

# module "prod" {
#   source = "./env/prod"

#   email = local.email
# }

# module "s3-audited" {
#   source = "./s3-audited"
# }

# module "sso" {
#   source = "./sso"
# }
