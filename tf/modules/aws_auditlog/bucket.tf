resource "aws_s3_bucket" "bucket" {
  bucket = var.name
  acl    = "log-delivery-write"

  lifecycle_rule {

    id      = "log"
    enabled = true

    prefix = "log/"

    transition {
      days          = var.days_to_logs_transition
      storage_class = var.logs_transition_storage_type
    }

    expiration {
      days = var.days_to_logs_expiration
    }

  }

}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
