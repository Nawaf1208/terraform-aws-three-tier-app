variable "project_name" {
    description = "The Project Name"
    type = string
}

variable "vpc_id" {
    description = "The VPC ID"
    type = string
}

variable "db_subnet_ids" { 
    description = "Database Subnet IDs"
    type = list(string) 
}

variable "app_sg_id" {
    description = "Application Security Group ID"
    type = string
}

variable "db_username" { 
    description = "Database Username"
    type = string 
}
variable "db_password" { 
    description = "Database Password"
    type = string
}