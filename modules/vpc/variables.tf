variable "project_name" {
    description = "Name of the project used for tagging"
    type = string
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for the Public Subnets"
    type = list(string)
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for the Private Subnets"
    type = list(string)
}

variable "db_subnet_cidrs" {
    description = "List of CIDR blocks for the Database Subnets"
    type = list(string)
}

variable "azs" {
    description = "List of Availability Zones"
    type = list(string)
}