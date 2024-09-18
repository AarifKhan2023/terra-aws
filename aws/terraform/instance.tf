resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  subnet_id              = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "${var.environment}-${var.product}-ec2-${count.index + 1}"
  }
}

# Allocate Elastic IPs for each EC2 instance
resource "aws_eip" "web_eip" {
  count      = var.instance_count
  instance   = aws_instance.web[count.index].id

  tags = {
    Name = "${var.environment}-${var.product}-eip-${count.index + 1}"
  }
}