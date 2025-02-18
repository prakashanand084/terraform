resource "aws_instance" "import" {
  ami = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  key_name = "mynewkeypair"
  tags = {
    Name = "anandbabu"
  }
 # lifecycle {
 #   ignore_changes = [ tags, ]
 # }
 #lifecycle {
  # prevent_destroy = true
 #}
# lifecycle {
 #  create_before_destroy = true
 #}
}

