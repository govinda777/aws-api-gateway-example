resource "aws_route53_zone" "tg_route53_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "tg_route53_record" {
  zone_id = aws_route53_zone.tg_route53_zone.zone_id
  name    = var.source_domain_name
  type    = "CNAME" # or "A"
  ttl     = "300"

  # alias {
  #   name                   = target_domain_name
  #   zone_id                = hosted_zone_id
  #   evaluate_target_health = false
  # }

  records = [
    var.target_domain_name
  ]
}
