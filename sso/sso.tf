# SSO needs to be enabled manually via console :(
data "aws_ssoadmin_instances" "sso" {}

locals {
  sso_identity_store_id = tolist(data.aws_ssoadmin_instances.sso.identity_store_ids)[0]
  sso_instance_arn      = tolist(data.aws_ssoadmin_instances.sso.arns)[0]
}


data "aws_identitystore_group" "admin" {
  identity_store_id = local.sso_identity_store_id

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "admin"
  }
}

data "aws_identitystore_group" "developer" {
  identity_store_id = local.sso_identity_store_id

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "aws_dev"
  }
}

