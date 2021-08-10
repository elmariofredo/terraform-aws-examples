variable "acl" {
  type        = string
  default     = "private"
  description = "Bucket ACL"
}

variable "auditlog_bucket_name" {
  type        = string
  description = "Bucket name for storing access logs"
}

variable "aws_kms_key_buckets_arn" {
  description = "KMS key ARN for buckets"
  default     = null
  type        = string
}

variable "bucket" {
  type        = string
  description = "Bucket name"
}

variable "name" {
  type        = string
  description = "Bucket description [Tags]"
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

variable "lifecycle_rule_transition_days" {
  default     = 30
  description = "Days to trasit logs to different storage type"
  type        = number
}

variable "lifecycle_rule_transition_storage_class" {
  default     = "ONEZONE_IA"
  description = "Transition target storage type see https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-compare"
  type        = string
}

variable "read_users" {
  type        = list(any)
  default     = []
  description = "Users with read access"
}

variable "sse_algorithm" {
  default     = "aws:kms"
  description = "Serve side encryption algorithm"
  type        = string
}

variable "write_users" {
  type        = list(any)
  default     = []
  description = "Users with write access"
}
