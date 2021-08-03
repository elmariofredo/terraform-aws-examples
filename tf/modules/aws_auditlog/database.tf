locals {
  tmp_query_file    = "/tmp/tf-${aws_s3_bucket.audit_log.id}-create-audit-table.sql"
  tmp_query_string  = templatefile(
    "${path.module}/create_table.tmpl.sql",
    {
      database_name       = var.database_name,
      auditlog_bucket_name  = var.auditlog_bucket_name,
      table_name          = var.table_name,
    }
  )
  execute_query_cmd = "aws athena start-query-execution --query-string file://${local.tmp_query_file} --output json --query-execution-context Database=${aws_athena_database.audit_log.id} --result-configuration OutputLocation=s3://${aws_s3_bucket.audit_log.id}/athena"
}

resource "aws_athena_database" "audit_log" {
  name          = var.database_name
  bucket        = "${aws_s3_bucket.audit_log.id}/athena"
  force_destroy = true
}

# There is not support for query execution in aws module
# We need to make sure that AWS environment variable credentials are present during terraform execution
resource "null_resource" "create_athena_auditlog_table" {

  triggers = {
    db_template = "${local.tmp_query_string}-${local.execute_query_cmd}"
  }

  provisioner "local-exec" {
    command = <<EOF
cat << 'EOT' > ${local.tmp_query_file}
${local.tmp_query_string}
EOT
${local.execute_query_cmd}
    EOF
  }
}
