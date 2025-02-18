resource "aws_instance" "prod" {
  ami = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"
  key_name = "mynewkeypair"
  subnet_id = aws_subnet.prod.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "bastionhost-ec2"
  }
}
#creation of private server
resource "aws_instance" "pvt_server" {
  ami = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"
  key_name = "mynewkeypair"
  subnet_id = aws_subnet.prod_private.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "pvt-server"
  }
}