variable "region" {
  default = "ap-south-1"
}

variable "vpc_id" {
  description = "Default VPC Group"
  default     = "vpc-04c5017b2ef74457f"
}

variable "security_group_name" {
  description = "EC2 Security Group"
  default     = "EC2-security-group"
}
