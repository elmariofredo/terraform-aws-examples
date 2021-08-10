output "test_appslogs_aws_access_key_id" {
  value     = aws_iam_access_key.test_appslogs.id
  sensitive = true
}

output "test_appslogs_aws_secret_access_key" {
  value     = aws_iam_access_key.test_appslogs.secret
  sensitive = true
}

output "test_tools_write_aws_access_key_id" {
  value     = aws_iam_access_key.test_tools_write.id
  sensitive = true

}

output "test_tools_write_aws_secret_access_key" {
  value     = aws_iam_access_key.test_tools_write.secret
  sensitive = true
}

output "aws_kms_key_dev" {
  value = aws_kms_key.dev.arn
}
