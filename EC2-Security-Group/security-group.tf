# Data block to check if the security group exists
data "aws_security_groups" "existing_ec2_sg" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Local variable to decide if we need to create the security group
locals {
  create_security_group = length(data.aws_security_groups.existing_ec2_sg.ids) == 0
}

# Create security group if it doesn't exist
resource "aws_security_group" "ec2_sg" {
  count = local.create_security_group ? 1 : 0

  name        = var.security_group_name
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = var.security_group_name
  }
}