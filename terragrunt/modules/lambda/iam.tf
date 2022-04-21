data "aws_partition" "current" {}
data "aws_iam_policy_document" "tg_lambda_module_lambda_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type    = "Service"
      identifiers = [format("lambda.%s", data.aws_partition.current.dns_suffix)]
    }
    sid = "AllowLambdatoAssumeRole"
  }
}

resource "aws_iam_role" "tg_lambda_module_lambda_iam_role" {
  name                = format("%s-role", var.function_name)
  path                = var.iam_role_path
  assume_role_policy  = data.aws_iam_policy_document.tg_lambda_module_lambda_iam_policy_document.json
  managed_policy_arns = var.lambda_iam_managed_policy_arns

  tags = {
    Name = "${var.tag_product_name}.${var.tag_environment_name}.${var.function_name}"
  }
}

resource "aws_iam_role_policy" "tg_lambda_module_lambda_iam_inline_policy" {
  name   = format("%s_lambda_iam_role_policy", var.function_name)
  role   = aws_iam_role.tg_lambda_module_lambda_iam_role.id
  policy = var.lambda_iam_policy

  lifecycle {
    create_before_destroy = true
  }
}