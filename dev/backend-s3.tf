terraform {
  backend "s3" {
    bucket         = "manage-terraform-state-bucket"
    key            = "terraform/dev-terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}