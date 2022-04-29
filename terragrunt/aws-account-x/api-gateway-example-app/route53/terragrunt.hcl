locals {
  global  = yamldecode(file(find_in_parent_folders("global.yaml")))
  account = yamldecode(file(find_in_parent_folders("account.yaml")))
  env     = yamldecode(file(find_in_parent_folders("env.yaml")))
}

terraform {
  source = format("%s/modules/route53//.", get_parent_terragrunt_dir())
}

dependency "apigateway" {
  config_path = "../api-gateway/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = "api-gateway-example.com"
  source_domain_name = "users.api-gateway-example.com"
  target_domain_name = dependency.apigateway.outputs.target_domain_name
}
