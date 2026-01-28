output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.main.id
}

output "public_subnet_ids" {
    description = "List of Public Subnet IDs"
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    description = "List of Private Subnet IDs"
    value = aws_subnet.private[*].id
}

output "db_subnet_ids" {
    description = "List of Database Subnet IDs"
    value = aws_subnet.database[*].id
}

output "nat_gateway_id" {
    description = "List of NAT Gateway Public IPs"
    value = aws_eip.nat[*].public_ip
}

output "availability_zones" {
  description = "List of Availability Zones used"
  value       = var.azs
}