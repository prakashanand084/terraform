output "az" {
  value = aws_instance.dev.availability_zone
}

output "ip" {
  value = aws_instance.dev.public_ip
}

output "privateIp" {
  value = aws_instance.dev.private_ip
  sensitive = true
}