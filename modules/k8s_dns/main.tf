data "aws_route53_zone" "main" {
  name = "${var.domain}."
}

resource "aws_route53_record" "wildcard" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "*.${var.instance_name}.${var.domain}"
  type    = "CNAME"
  ttl     = "60"
  records = [var.ingress_loadbalancer_hostname]
}

