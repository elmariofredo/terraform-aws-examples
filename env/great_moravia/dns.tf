resource "aws_route53_zone" "subdomain" {
  name = "${var.name}.${var.parent_dns_zone.name}"
}

resource "aws_route53_record" "subdomain" {
  zone_id = var.parent_dns_zone.zone_id
  name    = "${var.name}.${var.parent_dns_zone.name}"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.subdomain.name_servers
}
