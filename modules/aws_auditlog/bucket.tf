#tfsec:ignore:AWS017 tfsec:ignore:AWS077
resource "aws_s3_bucket" "bucket" {
  acl    = "log-delivery-write"
  bucket = var.name

  lifecycle_rule {
    enabled = true
    id      = "log"
    prefix  = "log/"

    expiration {
      days = var.lifecycle_rule_expiration_days
    }

    transition {
      days          = var.lifecycle_rule_transition_days
      storage_class = var.lifecycle_rule_transition_storage_class
    }
  }
  # KMS encryption is not used for main bucket, no reqired for the content.
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}
