provider "aws" {
  
}
#calling Default AMI process as a Data source

# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "amazon" ]
#   filter {
#     name = "name"
#     values = [ "amzn2-ami-hvm-*-gp2" ]
#   }
#   filter {
#     name = "root-device-type"
#     values = [ "ebs" ]
#   }
#   filter {
#     name = "virtualization-type"
#     values = [ "hvm" ]
#   }
#   filter {
#     name = "architecture"
#     values = [ "x86_64" ]
#   }
# }


#Calling custom AMI process as data source

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "self" ]
  filter {
    name = "name"
    values = [ "backend-ami" ]
  }
}

resource "aws_instance" "dev-anand" {
  ami = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
tags = {
      Name = "dev"
    }
}
