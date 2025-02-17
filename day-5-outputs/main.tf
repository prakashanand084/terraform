resource "aws_instance" "dev" {
ami = "ami-085ad6ae776d8f09c"
instance_type = "t2.micro"
key_name = "mynewkeypair"
availability_zone = "us-east-1b"

tags = {
  Name = "dev"
}

}

terraform {
  backend "s3" {
    bucket         = "prakash-terraform-state-bucket"
    key           = "day-5/terraform.tfstate"
    region        = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
  }
}









