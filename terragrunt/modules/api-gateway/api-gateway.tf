resource "aws_apigatewayv2_api" "tg_api_gateway_module_api" {
  name          = var.api_gateway_name
  description   = var.api_gateway_description
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_domain_name" "tg_api_gateway_module_api_domain_name" {
  domain_name = var.api_gateway_domain_name

  domain_name_configuration {
    certificate_arn = var.acm_certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_stage" "tg_api_gateway_module_api_stage" {
  api_id      = aws_apigatewayv2_api.tg_api_gateway_module_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_api_mapping" "tg_api_gateway_module_api_mapping" {
  api_id      = aws_apigatewayv2_api.tg_api_gateway_module_api.id
  domain_name = aws_apigatewayv2_domain_name.tg_api_gateway_module_api_domain_name.id
  stage       = aws_apigatewayv2_stage.tg_api_gateway_module_api_stage.id
}

resource "aws_apigatewayv2_integration" "tg_api_gateway_module_api_integration" {
  api_id           = aws_apigatewayv2_api.tg_api_gateway_module_api.id
  integration_type = "AWS_PROXY"

  connection_type        = "INTERNET"
  description            = var.api_gateway_description
  integration_method     = "POST"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "tg_api_gateway_module_api" {
  api_id             = aws_apigatewayv2_api.tg_api_gateway_module_api.id
  route_key          = var.api_gateway_route_key
  authorization_type = "NONE" # Use JWT, AWS_IAM or CUSTOM for specific authorization
  target             = "integrations/${aws_apigatewayv2_integration.tg_api_gateway_module_api_integration.id}"
}
