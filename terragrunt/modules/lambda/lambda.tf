resource "aws_lambda_function" "tg_lambda_module_lambda_function" {
  function_name                  = var.function_name
  description                    = var.description
  role                           = aws_iam_role.tg_lambda_module_lambda_iam_role.arn
  handler                        = var.handler
  runtime                        = var.runtime
  publish                        = var.publish
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.concurrency
  timeout                        = var.lambda_timeout

  filename          = var.filename
  source_code_hash  = filebase64sha256(var.filename)
  s3_bucket         = var.filename == null ? data.aws_s3_object.tg_lambda_module_lambda_artifact_bucket[0].bucket : null
  s3_key            = var.filename == null ? data.aws_s3_object.tg_lambda_module_lambda_artifact_bucket[0].key : null
  s3_object_version = var.filename == null ? data.aws_s3_object.tg_lambda_module_lambda_artifact_bucket[0].version_id : null

  tags = {
    Name        = "${var.tag_product_name}.${var.tag_environment_name}.${var.function_name}"
    Description = var.description == null ? var.function_name : var.description
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = var.environment
    }
  }

  depends_on = [aws_cloudwatch_log_group.tg_lambda_module_lambda_log_group]
}
