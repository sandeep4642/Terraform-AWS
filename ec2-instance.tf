# Data block to get the existing security group by name
data "aws_security_group" "existing_ec2_sg" {
  filter {
    name   = "group-name"
    values = [var.security_group_name]
  }

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "ubuntu"

  # Use existing security group if it exists, otherwise use the newly created one
  vpc_security_group_ids = [data.aws_security_group.existing_ec2_sg.id]


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
