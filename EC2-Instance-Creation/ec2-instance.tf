resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "ubuntu"
  vpc_security_group_ids = [aws_security_group.ec2.id]

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
