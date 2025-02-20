

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "cust_vpc" {
  description = "Name of the VPC"
  type        = string
  default     = ""
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = ""
}



variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
  default     = ""
}

variable "internet_gateway_name" {
  description = "Name of the internet gateway"
  type        = string
  default     = ""
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
  default     = ""
}

variable "private_route_table_name" {
  description = "Name of the private route table"
  type        = string
  default     = ""
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = ""
}

variable "eip_name" {
  description = "Name of the Elastic IP"
  type        = string
  default     = ""
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = ""
}
