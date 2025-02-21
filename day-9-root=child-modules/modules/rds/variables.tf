variable "db_instance_type" {
  description = "The instance type of the RDS database"
  type        = string
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

