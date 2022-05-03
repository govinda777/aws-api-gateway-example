variable "api_gateway_name" {
  description = "A unique name for the api gateway."
  type        = string
}

variable "api_gateway_description" {
  description = "Description for the api gateway."
  type        = string
}

variable "api_gateway_domain_name" {
  description = "Domain name (with subdomain name) for accessing the api gateway."
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invocation ARN of the api lambda that has to be invoked for incoming api request."
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the api lambda that has to be invoked for incoming api request."
  type        = string
}

variable "api_gateway_route_key" {
  description = "Route key for the api gateway. This is a combination of HTTP request type and path of the api. for eg: 'GET /api/v1/users'."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of certificate managed by AWS Certificate Manager."
  type        = string
}
