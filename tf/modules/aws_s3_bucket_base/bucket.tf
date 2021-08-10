#tfsec:ignore:AWS017
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  acl    = var.acl

  tags = {
    Name = var.name
  }

  lifecycle_rule {
    enabled = (var.lifecycle_expiration_days != null)

    id = "expiration"

    expiration {
      days = var.lifecycle_expiration_days
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule_transition_days == null ? [] : [1]

    content {
      enabled = true
      id      = "transition"

      transition {
        days          = var.lifecycle_rule_transition_days
        storage_class = var.lifecycle_rule_transition_storage_class
      }
    }
  }

  lifecycle_rule {
    enabled = true

    id = "noncurrent_version_expiration"

    noncurrent_version_expiration {
      days = var.lifecycle_noncurrent_version_expiration_days
    }
  }

  logging {
    target_bucket = var.auditlog_bucket_name
    target_prefix = "log/${var.bucket}/"
  }


  dynamic "server_side_encryption_configuration" {
    for_each = var.aws_kms_key_buckets_arn == null ? [] : [1]

    content {
      rule {
        apply_server_side_encryption_by_default {
          kms_master_key_id = var.aws_kms_key_buckets_arn
          sse_algorithm     = var.sse_algorithm
        }
        bucket_key_enabled = true
      }
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
