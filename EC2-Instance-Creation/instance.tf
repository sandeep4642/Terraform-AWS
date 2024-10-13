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

# Resource block for creating the EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "ubuntu"

  # Use the correct security group ID
  vpc_security_group_ids = length(data.aws_security_groups.existing_ec2_sg.ids) > 0 ? [data.aws_security_groups.existing_ec2_sg.ids[0]] : []

  tags = {
    Name = var.vm_name
  }

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

# Output the public IP
output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}