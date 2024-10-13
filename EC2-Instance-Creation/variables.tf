variable "region" {
  default = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0dee22c13ea7a9a67" # Replace with your preferred AMI
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "vm_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume"
  type        = number
  default     = 8  # Example default size in GB
}


variable "vpc_id" {
  description = "Default VPC Group"
  default     = "vpc-04c5017b2ef74457f"
}

variable "security_group_name" {
  description = "EC2 Security Group"
  default     = "EC2-security-group"
}
