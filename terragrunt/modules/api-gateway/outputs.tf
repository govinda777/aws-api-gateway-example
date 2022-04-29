output "api_endpoint" {
  value       = aws_apigatewayv2_api.tg_api_gateway_module_api.api_endpoint
  description = "The URI of the API"
}

output "execution_arn" {
  value       = aws_apigatewayv2_api.tg_api_gateway_module_api.execution_arn
  description = "The execution arn of the API that can be used to authorize access"
}

output "arn" {
  value       = aws_apigatewayv2_api.tg_api_gateway_module_api.arn
  description = "The ARN of the API"
}

output "target_domain_name" {
  value       = aws_apigatewayv2_domain_name.tg_api_gateway_module_api_domain_name.domain_name_configuration[0].target_domain_name
  description = "The custom domain name of the API"
}

output "hosted_zone_id" {
  value       = aws_apigatewayv2_domain_name.tg_api_gateway_module_api_domain_name.domain_name_configuration[0].hosted_zone_id
  description = "The hosted zone id of the API"
}
