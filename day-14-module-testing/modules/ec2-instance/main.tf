variable "env_name" {}
variable "instance_type" {}

resource "aws_instance" "name" {
  ami             = "ami-085ad6ae776d8f09c"
  instance_type   = var.instance_type
  key_name        = "mynewkeypair"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = var.env_name
  }
}