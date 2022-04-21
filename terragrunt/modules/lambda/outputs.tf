output "arn" {
  value       = aws_lambda_function.tg_lambda_module_lambda_function.arn
  description = "Lambda ARN"
}

output "version" {
  value       = aws_lambda_function.tg_lambda_module_lambda_function.version
  description = "Lambda Version"
}

output "name" {
  value       = aws_lambda_function.tg_lambda_module_lambda_function.function_name
  description = "Lambda Name"
}

output "invoke_arn" {
  value       = aws_lambda_function.tg_lambda_module_lambda_function.invoke_arn
  description = "ARN to invoke the lambda method"
}

output "cloudwatch_logs_name" {
  value       = aws_cloudwatch_log_group.tg_lambda_module_lambda_log_group.name
  description = "Cloudwatch log group name"
}
