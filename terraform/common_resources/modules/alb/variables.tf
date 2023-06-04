variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_a_id" {
  description = "The ID of the Public Subnet A"
  type        = string
}

variable "public_c_id" {
  description = "The ID of the Public Subnet C"
  type        = string
}

variable "aws_acm_certificate_cert_arn" {
  description = "The ARN of the Certificate"
  type        = string
}