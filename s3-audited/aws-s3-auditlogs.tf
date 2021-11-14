resource "aws_kms_key" "dev" {
  enable_key_rotation = true
}

module "aws_auditlog" {
  source = "../modules/aws_auditlog"

  name = "audit-log-bucket.org.vejlupek"
  read_users = [
    aws_iam_user.test_appslogs.name,
    aws_iam_user.test_tools_write.name,
  ]
  region = "eu-central-1"
}
