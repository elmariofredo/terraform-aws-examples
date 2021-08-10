resource "aws_kms_key" "dev" {
  enable_key_rotation = true
}

module "aws_auditlog" {
  source = "./modules/aws_auditlog"

  name = "audit-log-bucket.org.vejlupek"
  read_users = [
    aws_iam_user.test_appslogs.name,
    aws_iam_user.test_tools_write.name,
  ]
  region = "eu-central-1"
}

module "aws_s3_bucket_base_some_awesome_tool" {
  source = "./modules/aws_s3_bucket_base"

  auditlog_bucket_name = module.aws_auditlog.bucket.id
  bucket               = "some-awesome-tool.org.vejlupek"
  name                 = "Awesome tool data"
  read_users = [
    aws_iam_user.test_tools_write.name,
  ]
}

module "aws_s3_bucket_base_fluentbit-logs" {
  source = "./modules/aws_s3_bucket_base"

  auditlog_bucket_name = module.aws_auditlog.bucket.id
  bucket               = "fluentbit-logs.logging.org.vejlupek"
  name                 = "Test bucket for auditing"
  write_users = [
    aws_iam_user.test_appslogs.name,
  ]
}

