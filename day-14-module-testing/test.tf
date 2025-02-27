module "test_instance" {
  source        = "./modules/ec2-instance"
  env_name      = "test"
  instance_type = "t3.micro"
}