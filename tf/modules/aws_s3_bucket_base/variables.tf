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
  description = "Bucket type e.g. Applogs, Tools, Appdata, ... [Tags]"
}

variable "read_users" {
  type        = list
  default     = []
  description = "Users with read access"
}

variable "write_users" {
  type        = list
  default     = []
  description = "Users with write access"
}

variable "auditlog_bucket_id" {
  type        = string
  default     = ""
  description = "Enable storing bucket access logs to `auditlog_bucket_id`"
}

variable "public_access" {
  type        = bool
  default     = "false"
  description = "Enable bucket public access"
}

variable "acl" {
  type    = string
  default = "private"
  description = "Bucket ACL"
}
