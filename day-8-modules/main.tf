module "dev-anand" {
  source = "../day-2-basic-code-for- module-source"
  ami_id = "ami-085ad6ae776d8f09c"
   type = "t2.nano"
   key = "mynewkeypair"
}