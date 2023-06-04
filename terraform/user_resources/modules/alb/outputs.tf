output "aws_lb_target_group_main_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.main.arn
}
