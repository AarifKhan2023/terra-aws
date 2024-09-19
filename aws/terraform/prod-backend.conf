terraform {
  backend "s3" {
    bucket         = "prod-manage-terraform-state-bucket"
    key            = "terraform/prod-terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "prod-terraform-lock"
    encrypt        = true
  }
}