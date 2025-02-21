resource "aws_instance" "this" {
  ami           = "ami-053a45fff0a704a47"  # Replace with a valid AMI
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2"
  }
}
