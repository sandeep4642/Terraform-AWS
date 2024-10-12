data "aws_security_group" "existing_ec2_sg" {
  filter {
    name   = "ec2-sg"
    values = [var.security_group_name]
  }

  # The VPC ID where the security group is located (optional, but recommended)
  vpc_id = var.vpc_id
}

# Create security group if it doesn't exist
resource "aws_security_group" "ec2_sg" {
  count = length(data.aws_security_group.existing_ec2_sg.id) == 0 ? 1 : 0

  name        = var.security_group_name
  description = "Security group for EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access (adjust as needed)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  vpc_id = var.vpc_id

  tags = {
    Name = var.security_group_name
  }
}