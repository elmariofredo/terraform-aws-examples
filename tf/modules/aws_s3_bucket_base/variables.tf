variable "bucket" {
  type        = string
  description = "Bucket name"
}

variable "description" {
  type        = string
  description = "Bucket description [Tags]"
}

variable "environment" {
  type        = string
  description = "Bucket environment [Tags]"
}

variable "type" {
  type        = string
  description = "Bucket type e.g. AppsLogs, AppsData, ToolsData, ToolsLogs ... [Tags]"
}

variable "read_users" {
  type        = list(string)
  default     = []
  description = "Users with read access"
}

variable "write_users" {
  type        = list(string)
  default     = []
  description = "Users with write access"
}

variable "auditlog_bucket_name" {
  type        = string
  description = "Bucket name for storing access logs"
}

variable "acl" {
  type        = string
  default     = "private"
  description = "Bucket ACL"
}

variable "lifecycle_expiration_days" {
  type        = number
  default     = null
  description = "Bucket object expiration days"
}

variable "lifecycle_noncurrent_version_expiration_days" {
  type        = number
  default     = 30
  description = "Bucket object expiration days"
}
