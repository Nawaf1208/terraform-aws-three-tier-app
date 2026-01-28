variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC (passed from VPC module)"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "instance_type" {
  description = "The size of the EC2 instance"
  type        = string
  default     = "t2.micro"
}
