terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }

  backend "s3" {
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
  source      = "./modules/alb"
  app_name    = var.app_name
  vpc_id      = module.network.vpc_id
  public_a_id = module.network.public_a_id
  public_c_id = module.network.public_c_id
  depends_on  = [module.network]
}

module "route53" {
  source       = "./modules/route53"
  domain       = var.domain
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "ecr" {
  source   = "./modules/ecr"
  app_name = var.app_name
}