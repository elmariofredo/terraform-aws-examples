resource "aws_iam_user" "test_appslogs" {
  name = "testappslogsuser"
  path = "/"
}

resource "aws_iam_access_key" "test_appslogs" {
  user = aws_iam_user.test_appslogs.name
}


resource "aws_iam_user" "test_tools_write" {
  name = "testtoolswriteuser"
  path = "/"
}

resource "aws_iam_access_key" "test_tools_write" {
  user = aws_iam_user.test_tools_write.name
}
