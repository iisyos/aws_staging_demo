resource "aws_route53_record" "main" {
   zone_id = var.aws_route53_zone_main_zone_id
   name    = var.environment
   type    = "A"
   alias {
       name                   = var.alb_dns_name
       zone_id                = var.alb_zone_id
       evaluate_target_health = true
   }
}
