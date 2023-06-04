variable "environment" {
  description = "The name of environment"
  type        = string
}

variable "aws_route53_zone_main_zone_id" {
  description = "The ID of the Route53 Zone"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}
