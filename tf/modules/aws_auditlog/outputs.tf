output "bucket" {
  description = "Auditlog bucket resource"
  value       = aws_s3_bucket.bucket
}

output "auditlog_athena_database_name" {
  description = "Auditlog Athena database name"
  value       = var.database_name
}

output "auditlog_athena_table_name" {
  description = "Auditlog Athena table name"
  value       = var.table_name
}
