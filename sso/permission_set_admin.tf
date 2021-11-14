resource "aws_ssoadmin_permission_set" "dev_admin" {
  name         = "DevAdmin"
  instance_arn = local.sso_instance_arn
}

resource "aws_ssoadmin_managed_policy_attachment" "dev_admin" {
  instance_arn       = local.sso_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
  permission_set_arn = aws_ssoadmin_permission_set.dev_admin.arn
}
