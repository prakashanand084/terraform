



provider "aws" {
  region = var.aws_region
}

# Create VPC
resource "aws_vpc" "prod" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.cust_vpc
  }
}

# Create Public Subnet
resource "aws_subnet" "prod" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = var.public_subnet_cidr
  
  tags = {
    Name = var.public_subnet_name
  }
}

# Create Private Subnet
resource "aws_subnet" "prod_private" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = var.private_subnet_cidr
  tags = {
    Name = var.private_subnet_name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Create Public Route Table
resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id
  route {
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = var.public_route_table_name
  }
}

# Public Route Table Association
resource "aws_route_table_association" "prod" {
  route_table_id = aws_route_table.prod.id
  subnet_id      = aws_subnet.prod.id
}

# Create Security Group
resource "aws_security_group" "allow_tls" {
  name        = var.security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from SSH"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = var.security_group_name
  }
}

# Create Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = var.eip_name
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "prod_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.prod.id
  tags = {
    Name = var.nat_gateway_name
  }
  depends_on = [aws_internet_gateway.prod]
}

# Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod_nat.id
  }
  tags = {
    Name = var.private_route_table_name
  }
}

# Private Route Table Association
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.prod_private.id
  route_table_id = aws_route_table.private_rt.id
}
