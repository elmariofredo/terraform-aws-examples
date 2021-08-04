resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  acl    = var.acl

  tags = {
    Description = var.description
    Environment = var.environment
    Type        = var.type
  }

  lifecycle_rule {
    id      = "expiration"
    enabled = (var.lifecycle_expiration_days != null)

    expiration {
      days = var.lifecycle_expiration_days
    }
  }

  lifecycle_rule {
    id      = "noncurrent_version_expiration"
    enabled = true

    noncurrent_version_expiration {
      days = var.lifecycle_noncurrent_version_expiration_days
    }
  }

  versioning {
    enabled = true
  }

  logging {
    target_bucket = var.auditlog_bucket_name
    target_prefix = "log/${var.bucket}/"
  }

}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
