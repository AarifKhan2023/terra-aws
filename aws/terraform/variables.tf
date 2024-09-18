variable "aws_region" {
  description = "AWS region for Terraform"
  type        = string
}

/*variable "role_arn" {
  description = "The ARN of the IAM role to assume"
  type        = string
}*/

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "product" {
  description = "Product name"
  type        = string
}

variable "allowed_ports" {
  description = "List of ports to allow inbound traffic"
  type        = list(number)
  default     = [80, 22, 443]
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "azs" {
  description = "Availability zones in ap-south-1"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
}

variable "image_id" {
  type        = string
}

variable "key_dynamodb" {
  type        = string
}
variable "table_dynamodb" {
  type        = string
}

variable "backend_bucket" {
  type        = string
}