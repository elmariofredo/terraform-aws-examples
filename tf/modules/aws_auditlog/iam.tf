
resource "aws_iam_group" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name = "aditlogs_read"
}

resource "aws_iam_group_membership" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name  = "aditlogs_read"

  users = var.read_users

  group = aws_iam_group.aditlogs_read[0].name
}

resource "aws_iam_group_policy" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name  = "aditlogs_read"
  group = aws_iam_group.aditlogs_read[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListAllBuckets"
        Resource = "*"
        Effect   = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
        ]
      },
      {
        Sid = "ListBucket"
        Resource = [
          "${aws_s3_bucket.bucket.arn}",
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Effect = "Allow"
        Action = [
          "s3:GetObject",
        ]
      }
    ]
  })
}
