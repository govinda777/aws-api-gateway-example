resource "aws_cloudwatch_log_group" "tg_lambda_module_lambda_log_group" {
  name              = format("/aws/lambda/%s", var.function_name)
  retention_in_days = var.log_retention

  tags = {
    Name     = "${var.tag_product_name}.${var.tag_environment_name}.${var.function_name}"
    Function = format("%s", var.function_name)
  }
}