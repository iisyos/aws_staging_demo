terraform {
  source = "./"
}

locals {
  env = yamldecode(
    file(find_in_parent_folders("env.yaml"))
  )
}

include {
  path = find_in_parent_folders()
}

inputs = {
  app_name    = local.env.app_name
  environment = local.env.environment
  domain      = local.env.domain_name
}

remote_state {
  backend = "s3"
  disable_dependency_optimization = true

  config = {
    encrypt        = true
    bucket         = "${get_env("STATE_BUCKET", local.env.state_bucket)}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-northeast-1"
  }
}
