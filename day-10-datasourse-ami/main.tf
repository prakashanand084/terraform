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
}