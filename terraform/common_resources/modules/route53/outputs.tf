output "aws_route53_zone_main_zone_id" {
  description = "The ID of the Route53 Zone"
  value       = aws_route53_zone.main.zone_id
}

output "aws_acm_certificate_cert_arn" {
  description = "The ARN of the Certificate"
  value       = aws_acm_certificate.main.arn
}