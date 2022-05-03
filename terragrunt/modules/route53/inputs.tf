variable "domain_name" {
  description = "Your domain name or AWS hosted zone name."
  type        = string
}

variable "source_domain_name" {
  description = "Source domain for route53 CNAME record."
  type        = string
}

variable "target_domain_name" {
  description = "Target domain to route to for route53 CNAME record."
  type        = string
}
