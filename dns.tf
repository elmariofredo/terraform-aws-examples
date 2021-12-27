resource "aws_route53_zone" "main" {
  name = local.domain

  lifecycle {
    prevent_destroy = true
  }

}
