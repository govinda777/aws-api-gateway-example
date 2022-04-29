locals {
  global  = yamldecode(file(find_in_parent_folders("global.yaml")))
  account = yamldecode(file(find_in_parent_folders("account.yaml")))
  env     = yamldecode(file(find_in_parent_folders("env.yaml")))
}

terraform {
  source = format("%s/modules/acm//.", get_parent_terragrunt_dir())
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = "*.api-gateway-example.com"
}
