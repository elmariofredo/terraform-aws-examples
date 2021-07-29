resource "aws_resourcegroups_group" "tools" {
  name = "tools"

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = [
        "AWS::S3::Bucket"
      ],
      TagFilters = [
        {
          Key    = "Kind",
          Values = ["Tools"]
        }
      ]
    })

  }
}

resource "aws_resourcegroups_group" "apps" {
  name = "apps"

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = [
        "AWS::S3::Bucket"
      ],
      TagFilters = [
        {
          Key    = "Kind",
          Values = ["Apps"]
        }
      ]
    })

  }
}

resource "aws_iam_group" "appslogs_view" {
  name = "appslogs_view"
}

resource "aws_iam_user" "test_appslogs" {
  name = "testappslogsuser"
  path = "/"
}

resource "aws_iam_access_key" "test_appslogs" {
  user = aws_iam_user.test_appslogs.name
}

resource "aws_iam_group_membership" "appslogs_view" {
  name = "appslogs_view"

  users = [
    aws_iam_user.test_appslogs.name,
  ]

  group = aws_iam_group.appslogs_view.name
}

resource "aws_iam_group_policy" "appslogs_view" {
  name  = "appslogs"
  group = aws_iam_group.appslogs_view.name

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
          "${aws_s3_bucket.fluentbit-logs.arn}"
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.fluentbit-logs.arn}/*"
        ]
        Effect = "Allow"
        Action = [
          "s3:GetObject",
        ]
      },
    ]
  })
}


resource "aws_iam_group" "tools_write" {
  name = "tools_write"
}

resource "aws_iam_user" "test_tools_write" {
  name = "testtoolswriteuser"
  path = "/"
}

resource "aws_iam_access_key" "test_tools_write" {
  user = aws_iam_user.test_tools_write.name
}

resource "aws_iam_group_membership" "tools_write" {
  name = "tools_write"

  users = [
    aws_iam_user.test_tools_write.name,
  ]

  group = aws_iam_group.tools_write.name
}

resource "aws_iam_group_policy" "tools_write" {
  name  = "tools_write"
  group = aws_iam_group.tools_write.name

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
          "${aws_s3_bucket.some_awesome_tool.arn}",
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.some_awesome_tool.arn}/*",
        ]
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
        ]
      }
    ]
  })
}



resource "aws_iam_group" "aditlogs_read" {
  name = "aditlogs_read"
}

resource "aws_iam_group_membership" "aditlogs_read" {
  name = "aditlogs_read"

  users = [
    aws_iam_user.test_appslogs.name,
    aws_iam_user.test_tools_write.name,
  ]

  group = aws_iam_group.aditlogs_read.name
}

resource "aws_iam_group_policy" "aditlogs_read" {
  name  = "aditlogs_read"
  group = aws_iam_group.aditlogs_read.name

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
          "${aws_s3_bucket.audit_log.arn}",
        ]
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
      },
      {
        Sid = "Read"
        Resource = [
          "${aws_s3_bucket.audit_log.arn}/*",
        ]
        Effect = "Allow"
        Action = [
          "s3:GetObject",
        ]
      }
    ]
  })
}
