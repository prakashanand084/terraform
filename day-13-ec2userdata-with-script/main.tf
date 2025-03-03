
resource "aws_instance" "test" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    key_name = "mynewkeypair"
    availability_zone = "us-east-1a"
    user_data= file("test.sh")
}