output "arn" {
  value       = aws_acm_certificate.tg_acm_certificate.arn
  description = "The ARN of the certificate managed by AWS Certificate Manager"
}
