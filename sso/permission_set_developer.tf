resource "aws_ssoadmin_permission_set" "prod_developer" {
  name         = "ProdDeveloper"
  instance_arn = local.sso_instance_arn
}

data "aws_iam_policy_document" "prod_developer" {
  statement {
    sid = "s3"

    actions = [
      "s3:Get*",
      "s3:HeadObject",
      "s3:List*",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    sid = "eks"
    actions = [
      "eks:AccessKubernetesApi",
      "eks:ListClusters",
      "eks:DescribeCluster",
      "eks:ListNodegroups",
      "eks:ListUpdates",
      "eks:ListAddons",
    ]
    resources = [
      "arn:aws:eks:*",
    ]
  }

  statement {
    sid = "rds"
    actions = [
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeGlobalClusters",
    ]
    resources = [
      "arn:aws:rds:eu-central-1:850408771688:db:*",
      "arn:aws:rds:eu-central-1:*:cluster:*",
      "arn:aws:rds::850408771688:global-cluster:*",
    ]
  }

}


resource "aws_ssoadmin_permission_set_inline_policy" "prod_developer" {
  inline_policy      = data.aws_iam_policy_document.prod_developer.json
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.prod_developer.arn
}
