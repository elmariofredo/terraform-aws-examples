variable "auditlog_bucket_name" {
  type = string
  description = "Auditlog bucket name"
}

variable "database_name" {
  type        = string
  default     = "audit_log"
  description = "Athena auditlog database name"
}

variable "table_name" {
  type        = string
  default     = "buckets"
  description = "Athena auditlog table name"
}

variable "read_users" {
  type        = list
  default     = []
  description = "Users with auditlog read access"
}
