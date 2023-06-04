resource "aws_route53_zone" "main" {
   name = var.domain
}

resource "aws_route53_record" "main" {
   zone_id = aws_route53_zone.main.zone_id
   name    = var.app_name
   type    = "A"
   alias {
       name                   = var.alb_dns_name
       zone_id                = var.alb_zone_id
       evaluate_target_health = true
   }
}

resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name = "${var.environment}-wildcard-sslcert"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_zone.main
  ]
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn = aws_acm_certificate.main.arn
  validation_record_fqdns = [aws_route53_record.main.fqdn]
}