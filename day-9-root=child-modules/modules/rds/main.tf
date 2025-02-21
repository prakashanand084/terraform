resource "aws_db_instance" "example" {
  identifier             = var.db_name
  allocated_storage      = 20
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = var.db_instance_type
  username             = var.db_username
  password             = var.db_password
  publicly_accessible   = false
  skip_final_snapshot   = true

  tags = {
    Name = "Terraform-RDS"
  }
}

