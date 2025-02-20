module "dev-anand" {
  source = "../day-8-module-of-custnw"
  
aws_region               = "us-east-1"
vpc_cidr                 = "10.0.0.0/16"
public_subnet_cidr       = "10.0.0.0/24"
private_subnet_cidr      = "10.0.1.0/24"
cust_vpc                 = "prod"
public_subnet_name       = "prod_subnet"
private_subnet_name      = "private-subnet"
internet_gateway_name    = "prod_IG"
public_route_table_name  = "public_RT"
private_route_table_name = "pvt_RT"
security_group_name      = "allow_tls"
eip_name                 = "NAT EIP"
nat_gateway_name         = "myNAT"

}