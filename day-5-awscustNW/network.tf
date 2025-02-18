resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod"
  }
}
#creating of public subnet
resource "aws_subnet" "prod" {
  vpc_id = aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "prod_subnet"
  }
  
}
#creating private subnet
resource "aws_subnet" "prod_private" {
  vpc_id = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}
#creating internet gateway
resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "prod_IG"
  }
}
#creating public route table and edit
resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.prod.id
  route {
    gateway_id = aws_internet_gateway.prod.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "public_RT"
  }
}
#creating public route table association
resource "aws_route_table_association" "prod" {
  route_table_id = aws_route_table.prod.id
  subnet_id = aws_subnet.prod.id
}
#creating security group
resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.prod.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from ssh"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}
#creating elastic ip
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "NAT EIP"
  }
}
#creating NAT gateway
resource "aws_nat_gateway" "prod_nat" {
allocation_id = aws_eip.nat_eip.id
subnet_id = aws_subnet.prod.id
tags = {
  Name = "myNAT"
}
depends_on = [ aws_internet_gateway.prod ]

}
#creating private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod_nat.id
  }

  tags = {
    Name = "pvt_RT"
  }

}
#private route table association
resource "aws_route_table_association" "private_assoc" {
  subnet_id = aws_subnet.prod_private.id
  route_table_id = aws_route_table.private_rt.id
}