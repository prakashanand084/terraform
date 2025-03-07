variable "rds-password" {
    description = "rds password"
    type = string
    default = "Cloud123"
  
}
variable "rds-username" {
    description = "rds username"
    type = string
    default = "admin"
  
}
variable "ami" {
    description = "ami"
    type = string
    default = "ami-04b4f1a9cf54c11d0"
  
}
variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t2.micro"
  
}
variable "key-name" {
    description = "keyname"
    type = string
    default = "ubuntukeypair"
  
}
variable "backupr-retention" {
    type = number
    default = "7"
  
}