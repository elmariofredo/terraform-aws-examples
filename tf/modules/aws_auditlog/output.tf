output "auditlog_bucket" {
  value = aws_s3_bucket.audit_log
}

output "auditlog_athena_database_name" {
  value = var.database_name
}

output "auditlog_athena_table_name" {
  value = var.table_name
}
