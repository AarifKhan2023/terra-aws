resource "aws_key_pair" "key-tf" {
  key_name   = "${var.environment}-${var.product}-key"
  public_key = file("${path.module}/id_rsa.pub")
}