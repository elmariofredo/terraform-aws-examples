module "aws_auditlog" {
  source                = "../tf/modules/aws_auditlog"

  name                  = "audit-log-bucket.org.vejlupek"
  
  read_users            = [
    aws_iam_user.test_appslogs.name,
    aws_iam_user.test_tools_write.name,
  ]
}

module "aws_s3_bucket_base_some_awesome_tool" {
  source              = "../tf/modules/aws_s3_bucket_base"

  bucket              = "some-awesome-tool.org.vejlupek"
  description         = "Awesome tool data"
  environment         = "Dev"
  type                = "ToolsData"
  read_users          = [
    aws_iam_user.test_tools_write.name,
  ]
  auditlog_bucket_id  = module.aws_auditlog.bucket.id
}

module "aws_s3_bucket_base_fluentbit-logs" {
  source              = "../tf/modules/aws_s3_bucket_base"

  bucket              = "fluentbit-logs.logging.org.vejlupek"
  description         = "Test bucket for auditing"
  environment         = "Dev"
  type                = "AppLogs"
  write_users         = [
    aws_iam_user.test_appslogs.name,
  ]
  auditlog_bucket_id  = module.aws_auditlog.bucket.id
}

