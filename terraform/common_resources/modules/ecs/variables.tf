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

variable "aws_lb_target_group_main_arn" {
  description = "The ARN of the Target Group"
  type        = string
}

variable "aws_security_group_alb_id" {
  description = "The ID of the Security Group"
  type        = string
}

variable "image_url" {
  description = "The URL of the Docker image"
  type = string
}
