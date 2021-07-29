
resource "aws_s3_bucket" "audit_log" {
  bucket = "audit-log-bucket.org.vejlupek"
  acl    = "log-delivery-write"
}


resource "aws_s3_bucket_public_access_block" "audit_log" {
  bucket                  = aws_s3_bucket.audit_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "some_awesome_tool" {
  bucket = "some-awesome-tool.org.vejlupek"
  acl    = "private"

  tags = {
    Name        = "Test bucket for auditing"
    Environment = "Dev"
    Kind        = "Tools"
  }

  logging {
    target_bucket = aws_s3_bucket.audit_log.id
    target_prefix = "log/some-awesome-tool.org.vejlupek/"
  }
}

resource "aws_s3_bucket_public_access_block" "some_awesome_tool" {
  bucket                  = aws_s3_bucket.some_awesome_tool.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "fluentbit-logs" {
  bucket = "fluentbit-logs.logging.org.vejlupek"
  acl    = "private"

  tags = {
    Name        = "Test bucket for auditing"
    Environment = "Dev"
    Kind        = "Apps"
  }

  logging {
    target_bucket = aws_s3_bucket.audit_log.id
    target_prefix = "log/fluentbit-logs.logging.org.vejlupek/"
  }
}

resource "aws_s3_bucket_public_access_block" "fluentbit-logs" {
  bucket                  = aws_s3_bucket.fluentbit-logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
