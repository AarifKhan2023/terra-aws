terraform {
  backend "s3" {
    bucket         = "${terraform.workspace}-manage-terraform-state-bucket"
    key            = "terraform/${terraform.workspace}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "${terraform.workspace}-terraform-lock"
    encrypt        = true
  }
}