terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "aws_access_key" {
  type = string
  sensitive = true
}
variable "aws_secret_key" {
  type = string
  sensitive = true
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "rossumai_audit_log_bucket" {
  bucket = "rossumai-audit-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "bucket-test1" {
  bucket = "tf-audit-test1-bucket"
  acl    = "private"

  tags = {
    Name        = "Test bucket for auditing"
    Environment = "Dev"
  }

  logging {
    target_bucket = aws_s3_bucket.rossumai_audit_log_bucket.id
    target_prefix = "log/"
  }
}
