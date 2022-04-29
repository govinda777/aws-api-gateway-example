output "name" {
  value       = aws_route53_record.tg_route53_record.name
  description = "The name of the route53 record."
}

output "fqdn" {
  value       = aws_route53_record.tg_route53_record.fqdn
  description = "FQDN built using the zone domain and name."
}
