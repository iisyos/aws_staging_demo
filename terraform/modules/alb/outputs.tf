output "aws_lb_target_group_main_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.main.arn
}

output "aws_security_group_alb_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.alb.id
}
