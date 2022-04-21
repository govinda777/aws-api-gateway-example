data "aws_s3_object" "tg_lambda_module_lambda_artifact_bucket" {
  count  = var.filename == null ? 1 : 0
  bucket = var.lambda_file_s3_bucket_name
  key    = var.lambda_filename_s3_path
}