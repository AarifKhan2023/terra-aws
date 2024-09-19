terraform {
  backend "s3" {
    bucket         = var.backend_bucket
    key            = var.key_dynamodb
    region         = var.aws_region
    dynamodb_table = var.table_dynamodb
    encrypt        = true
  }
}