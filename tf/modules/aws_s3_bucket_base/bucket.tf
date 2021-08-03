resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
  acl    = var.acl

  tags = {
    Description = var.description
    Environment = var.environment
    Type        = var.type
  }

  dynamic "logging" {
    for_each = var.auditlog_bucket_id == "" ? [] : [1]
    content {
      target_bucket = var.auditlog_bucket_id
      target_prefix = "log/${var.bucket}/"
    }
  }

}

resource "aws_s3_bucket_public_access_block" "bucket" {
  count                   = var.public_access ? 0 : 1

  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
