resource "aws_iam_group" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name = "${var.bucket}-read"
}

resource "aws_iam_group_membership" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name = "${var.bucket}-read"

  users = var.read_users

  group = aws_iam_group.read[0].name
}

resource "aws_iam_group_policy" "read" {
  count = length(var.read_users) == 0 ? 0 : 1

  name  = "${var.bucket}-read"
  group = aws_iam_group.read[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListAllBuckets"
        Resource = "*"
        Effect   = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
      },
      {
        Sid = "ListBucket"
        Resource = [
          "${aws_s3_bucket.bucket.arn}"
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
        Effect = "Allow"
        Action = [
          "s3:GetObject",
        ]
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

  name = "${var.bucket}-write"

  users = var.write_users

  group = aws_iam_group.write[0].name
}

resource "aws_iam_group_policy" "write" {
  count = length(var.write_users) == 0 ? 0 : 1

  name  = "${var.bucket}-write"
  group = aws_iam_group.write[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListAllBuckets"
        Resource = "*"
        Effect   = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets",
        ]
      },
      {
        Sid = "ListBucket"
        Resource = [
          "${aws_s3_bucket.bucket.arn}"
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
        Effect = "Allow"
        Action = [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject",
        ]
      },
    ]
  })
}
