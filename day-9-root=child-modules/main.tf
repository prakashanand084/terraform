provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
}

 module "s3_bucket" {
   source      = "./modules/s3"
   bucket_name = ""
 }

 module "rds" {
  source           = "./modules/rds"
  db_instance_type = var.db_instance_type
  db_username      = var.db_username
  db_password      = var.db_password
  db_name          = var.db_name
}