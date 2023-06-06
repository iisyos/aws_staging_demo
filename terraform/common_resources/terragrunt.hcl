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
