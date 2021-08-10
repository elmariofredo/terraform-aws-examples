resource "aws_iam_group" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name = "aditlogs_read_${var.region}"
}

resource "aws_iam_group_membership" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  group = aws_iam_group.aditlogs_read[0].name
  name  = "aditlogs_read_${var.region}"
  users = var.read_users
}

resource "aws_iam_group_policy" "aditlogs_read" {
  count = length(var.read_users) == 0 ? 0 : 1

  group = aws_iam_group.aditlogs_read[0].name
  name  = "aditlogs_read_${var.region}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
        ]
        Effect   = "Allow"
        Resource = "*"
        Sid      = "ListAllBuckets"
      },
      {
        Action = [
          "s3:ListBucket",
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.bucket.arn}",
        ]
        Sid = "ListBucket"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:HeadObject",
        ],
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
        ]
        Sid = "Read"
      }
    ]
  })
}
