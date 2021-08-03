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

variable "days_to_logs_expiration" {
  type        = number
  default     = 372
  description = "Days to expire logs"
}

variable "days_to_logs_transition" {
  type        = number
  default     = 30
  description = "Days to trasit logs to different storage type"
}

variable "logs_transition_storage_type" {
  type        = string
  default     = "ONEZONE_IA"
  description = "Transition target storage type see https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-compare"
}
