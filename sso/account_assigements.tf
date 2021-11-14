resource "aws_ssoadmin_account_assignment" "dev_admin" {
  instance_arn       = aws_ssoadmin_permission_set.dev_admin.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.dev_admin.arn

  principal_id   = data.aws_identitystore_group.developer.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_organization.org.accounts[0].id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "prod_developer" {
  instance_arn       = aws_ssoadmin_permission_set.prod_developer.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.prod_developer.arn

  principal_id   = data.aws_identitystore_group.developer.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_organization.org.accounts[0].id
  target_type = "AWS_ACCOUNT"
}
