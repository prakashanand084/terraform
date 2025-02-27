module "dev_instance" {
  source        = "./modules/ec2-instance"
  env_name      = "dev"
  instance_type = "t2.micro"
}