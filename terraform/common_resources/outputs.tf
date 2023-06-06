output "app_name" {
  value = var.app_name
}

output "domain" {
  value = var.domain
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "public_a_id" {
  description = "The ID of the Public Subnet A"
  value       = module.network.public_a_id
}

output "public_c_id" {
  description = "The ID of the Public Subnet C"
  value       = module.network.public_c_id
}

output "alb_zone_id" {
  description = "The Zone ID of the ALB"
  value       = module.alb.alb_zone_id
}

output "aws_lb_listener_main_arn" {
  description = "The ARN of the Listener"
  value       = module.alb.aws_lb_listener_main_arn
}

output "aws_security_group_alb_id" {
  description = "The ID of the Security Group"
  value       = module.alb.aws_security_group_alb_id
}

output "aws_route53_zone_main_zone_id" {
  description = "The Zone ID of the Route53 Zone"
  value       = module.route53.aws_route53_zone_main_zone_id
}

output "repository_url" {
  description = "URL of first repository created"
  value       = module.ecr.repository_url
}
