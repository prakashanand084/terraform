provider "aws" { 
    region = "us-east-1"
}

resource "aws_s3_bucket" "anand" {
  bucket = "testing-depend-on-bucket-anand"
}

resource "aws_instance" "dev-anand" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    depends_on = [ aws_s3_bucket.anand ]
}

resource "aws_s3_bucket" "anand-1" {
  bucket = "testing-depend-on-bucket-anand-1"
  
}