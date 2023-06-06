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

resource "random_uuid" "main" {
}
