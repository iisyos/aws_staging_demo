locals {
  env = yamldecode(
    file("env.yaml")
  )
}

remote_state {
  backend = "s3"
  disable_dependency_optimization = true

  config = {
    encrypt        = true
    bucket         = "${get_env("STATE_BUCKET", local.env.state_bucket)}"
    key            = "${get_env("ENVIRONMENT", path_relative_to_include())}/terraform.tfstate"
    region         = "ap-northeast-1"
  }
}
