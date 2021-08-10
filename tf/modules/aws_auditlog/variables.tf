variable "database_name" {
  type        = string
  default     = "audit_log"
  description = "Athena auditlog database name"
}

variable "name" {
  type        = string
  description = "Auditlog bucket name"
}

variable "region" {
  type        = string
  description = "Auditlog region"
}

variable "read_users" {
  type        = list(any)
  default     = []
  description = "Users with auditlog read access"
}

variable "table_name" {
  type        = string
  default     = "buckets"
  description = "Athena auditlog table name"
}

variable "lifecycle_rule_expiration_days" {
  type        = number
  default     = 372
  description = "Days to expire audit logs"
}

variable "lifecycle_rule_transition_days" {
  type        = number
  default     = 30
  description = "Days to trasit logs to different storage type"
}

variable "lifecycle_rule_transition_storage_class" {
  type        = string
  default     = "ONEZONE_IA"
  description = "Transition target storage type see https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-compare"
}
