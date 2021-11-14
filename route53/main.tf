resource "aws_route53_zone" "vejlupek_online" {
  name = "k8s.vejlupek.online"

  lifecycle {
    prevent_destroy = true
  }

}

