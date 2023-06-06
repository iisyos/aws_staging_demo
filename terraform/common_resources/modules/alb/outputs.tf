output "aws_security_group_alb_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.alb.id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "The Zone ID of the ALB"
  value       = aws_lb.main.zone_id
}

output "aws_lb_listener_main_arn" {
  description = "The ARN of the Listener"
  value       = aws_lb_listener.main.arn
}
