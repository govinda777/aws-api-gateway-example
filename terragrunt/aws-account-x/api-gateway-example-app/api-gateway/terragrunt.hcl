locals {
  global  = yamldecode(file(find_in_parent_folders("global.yaml")))
  account = yamldecode(file(find_in_parent_folders("account.yaml")))
  env     = yamldecode(file(find_in_parent_folders("env.yaml")))
}

terraform {
  source = format("%s/modules/api-gateway//.", get_parent_terragrunt_dir())
}

dependency "lambda" {
  config_path = "../lambda/"
}

dependency "acm" {
  config_path = "../acm/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  api_gateway_name = "api-gateway-example"
  api_gateway_description = "An example API Gateway"
  api_gateway_domain_name = "users.api-gateway-example.com"
  acm_certificate_arn = dependency.acm.outputs.arn
  lambda_invoke_arn = dependency.lambda.outputs.invoke_arn
  lambda_arn = dependency.lambda.outputs.arn
  api_gateway_route_key = "POST /users"
}
