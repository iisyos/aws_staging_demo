terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "alb" {
  source   = "./modules/alb"
  app_name = var.app_name
  vpc_id   = var.vpc_id
  environment   = var.environment
  domain = var.domain
  aws_lb_listener_main_arn = var.aws_lb_listener_main_arn
}

module "route53" {
  source   = "./modules/route53"
  environment   = var.environment
  aws_route53_zone_main_zone_id   = var.aws_route53_zone_main_zone_id
  alb_dns_name   = var.alb_dns_name
  alb_zone_id   = var.alb_zone_id
}

module "ecs" {
  source   = "./modules/ecs"
  app_name = var.app_name
  environment   = var.environment
  vpc_id   = var.vpc_id
  public_a_id   = var.public_a_id
  public_c_id   = var.public_c_id
  aws_lb_target_group_main_arn = module.alb.aws_lb_target_group_main_arn
  aws_security_group_alb_id = var.aws_security_group_alb_id
  depends_on = [module.alb, module.route53]
}