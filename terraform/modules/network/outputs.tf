output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_a_id" {
  description = "The ID of the Public Subnet A"
  value       = aws_subnet.public_a.id
}

output "public_c_id" {
  description = "The ID of the Public Subnet C"
  value       = aws_subnet.public_c.id
}
