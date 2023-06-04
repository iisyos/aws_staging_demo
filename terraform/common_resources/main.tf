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

module "network" {
  source   = "./modules/network"
  app_name = var.app_name
}

module "alb" {
  source   = "./modules/alb"
  app_name = var.app_name
  vpc_id   = module.network.vpc_id
  public_a_id   = module.network.public_a_id
  public_c_id   = module.network.public_c_id
  depends_on = [module.network]
}

module "ecs" {
  source   = "./modules/ecs"
  app_name = var.app_name
  vpc_id   = module.network.vpc_id
  public_a_id   = module.network.public_a_id
  public_c_id   = module.network.public_c_id
  aws_lb_target_group_main_arn = module.alb.aws_lb_target_group_main_arn
  aws_security_group_alb_id = module.alb.aws_security_group_alb_id
  depends_on = [module.alb]
}

module "route53" {
  source   = "./modules/route53"
  domain = var.domain
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}