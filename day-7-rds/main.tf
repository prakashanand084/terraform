resource "aws_vpc" "cust_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "cust-vpc"
  }
}

resource "aws_subnet" "cust_subnet1" {
  vpc_id = aws_vpc.cust_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "cust-subnet1"
  }
}

resource "aws_subnet" "cust_subnet2" {
  vpc_id = aws_vpc.cust_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "cust-subnet2"
  }
}

resource "aws_db_instance" "cust" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "cloud123"
  db_subnet_group_name = aws_db_subnet_group.sub-grp.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycustsubnet"
  subnet_ids = [aws_subnet.cust_subnet1.id, aws_subnet.cust_subnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}






