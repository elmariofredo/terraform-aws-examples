output "bucket" {
  value       = aws_s3_bucket.bucket
  description = "Auditlog bucket resource"
}

output "auditlog_athena_database_name" {
  value       = var.database_name
  description = "Auditlog Athena database name"
}

output "auditlog_athena_table_name" {
  value       = var.table_name
  description = "Auditlog Athena table name"
}
