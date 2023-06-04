variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "domain" {
  description = "The domain name"
  type        = string
}

variable "environment" {
  description = "The name of environment"
  type        = string
}

variable "aws_lb_listener_main_arn" {
  description = "The ARN of the Listener"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
