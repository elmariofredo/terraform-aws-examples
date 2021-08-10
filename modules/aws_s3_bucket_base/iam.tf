resource "aws_iam_group" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name = "${var.bucket}-read"
}

resource "aws_iam_group_membership" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  group = aws_iam_group.read[0].name
  name  = "${var.bucket}-read"
  users = var.read_users
}

resource "aws_iam_group_policy" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  group = aws_iam_group.read[0].name
  name  = "${var.bucket}-read"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
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
          "${aws_s3_bucket.bucket.arn}"
        ]
        Sid = "ListBucket"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:HeadObject",
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
        Sid = "Read"
      },
    ]
  })
}

resource "aws_iam_group" "write" {
  count = length(var.write_users) == 0 ? 0 : 1

  name = "${var.bucket}-write"
}

resource "aws_iam_group_membership" "write" {
  count = length(var.write_users) == 0 ? 0 : 1

  group = aws_iam_group.write[0].name
  name  = "${var.bucket}-write"
  users = var.write_users
}

resource "aws_iam_group_policy" "write" {
  count = length(var.write_users) == 0 ? 0 : 1

  group = aws_iam_group.write[0].name
  name  = "${var.bucket}-write"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
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
          "${aws_s3_bucket.bucket.arn}"
        ]
        Sid = "ListBucket"
      },
      {
        Action = [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:HeadObject", # List partly uploaded files
          "s3:PutObject",
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
        Sid = "Read"
      },
    ]
  })
}
