locals {
  global  = yamldecode(file(find_in_parent_folders("global.yaml")))
  account = yamldecode(file(find_in_parent_folders("account.yaml")))
  env     = yamldecode(file(find_in_parent_folders("env.yaml")))
}

terraform {
  source = format("%s/modules/lambda//.", get_parent_terragrunt_dir())
}

include {
  path = find_in_parent_folders()
}

inputs = {
  concurrency     = 1
  function_name   = "${local.env.resource_name_prefix}-sample-lambda"
  handler         = "src/index.handler"
  runtime         = "nodejs20.x"
  lambda_iam_policy = templatefile("policy.json", {
    account_id            = local.account.aws_account_id
    region                = local.account.aws_region
    lambda_name           = "${local.env.resource_name_prefix}-sample-lambda"
  })

  filename       = format("%s/../lambda/sample-lambda-function.zip", get_parent_terragrunt_dir())
  lambda_timeout = 120
  memory_size    = 512

  environment = {
    APP_NAME   = "Lambda_4_api_gateway_example"
  }

  description          = "a simple lambda function"
  tag_product_name     = local.global.product_name
  tag_environment_name = local.env.environment_name
}
