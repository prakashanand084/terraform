terraform {
  backend "s3" {
    bucket         = "prakash-terraform-state-bucket"
    key           = "terraform.tfstate"
    region        = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt = true
  }
}

