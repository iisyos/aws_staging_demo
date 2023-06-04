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