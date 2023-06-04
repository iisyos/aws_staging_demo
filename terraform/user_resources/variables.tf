variable "environment" {
  description = "The name of environment"
  type        = string
}

variable "app_name" {
  type = string
}

variable "domain" {
  type = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}

variable "aws_lb_listener_main_arn" {
  description = "The ARN of the Listener"
  type        = string
}

variable "aws_route53_zone_main_zone_id" {
  description = "The Zone ID of the Route53 Zone"
  type        = string
}

variable "aws_security_group_alb_id" {
  description = "The ID of the Security Group"
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

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "image_url" {
  description = "The URL of the Docker image"
  type        = string
  default     = "nginx"
}
