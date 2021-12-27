data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "main" {
  name = "great_moravia"
  path = "/"
}

resource "aws_iam_access_key" "main" {
  user    = aws_iam_user.main.name
}

resource "aws_iam_user_policy_attachment" "main_administrator_access" {
  user       = aws_iam_user.main.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

