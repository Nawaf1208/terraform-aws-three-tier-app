#VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "${var.project_name}-vpc"
    }
}

#Public Subnet (Web)
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-public_subnet-${count.index + 1}"
    }
}

#Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.project_name}-igw"
    }
}

#Public Route Table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "${var.project_name}-public-rt"
    }
}

#Public Route Table Association
resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

#Private Subnet (App)
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-private-subnet-${count.index + 1}"
    }
}

#Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
    count = length(var.public_subnet_cidrs)
    domain = "vpc"

    tags = {
      Name = "${var.project_name}-nat-eip-${count.index + 1}"
    }
  
}

#NAT Gateways
resource "aws_nat_gateway" "main" {
    count = length(var.public_subnet_cidrs)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = aws_subnet.public[count.index].id

    depends_on = [aws_internet_gateway.main]

    tags = {
        Name = "${var.project_name}-nat-${count.index + 1}"
    }
}

#Private Route Table
resource "aws_route_table" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main[count.index].id
    }

    tags = {
        Name = "${var.project_name}-private-rt-${count.index + 1}"
    }
}

#Private Route Table Association
resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}

#Private Subnet (Database)
resource "aws_subnet" "database" {
    count = length(var.db_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.db_subnet_cidrs[count.index]
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-db-subnet-${count.index + 1}"
    }
}