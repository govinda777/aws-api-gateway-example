resource "aws_lambda_event_source_mapping" "tg_lambda_module_lambda_event_source" {
  for_each = { for eventsource in var.event_sources : eventsource.arn => eventsource }

  function_name    = aws_lambda_function.tg_lambda_module_lambda_function.arn
  event_source_arn = each.value.arn
  enabled          = each.value.enabled
  batch_size       = each.value.batch_size
}
