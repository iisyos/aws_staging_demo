terraform {
  source = "./"
}

include {
  path = find_in_parent_folders()
}

dependency "common" {
  config_path = "../common_resources"
}

inputs = {
  environment = get_env("ENVIRONMENT", path_relative_to_include())
  image_url = get_env("IMAGE_URL", "nginx")
  app_name = dependency.common.outputs.app_name
  domain = dependency.common.outputs.domain
  alb_dns_name = dependency.common.outputs.alb_dns_name
  vpc_id = dependency.common.outputs.vpc_id
  public_a_id = dependency.common.outputs.public_a_id
  public_c_id = dependency.common.outputs.public_c_id
  alb_zone_id = dependency.common.outputs.alb_zone_id
  aws_lb_listener_main_arn = dependency.common.outputs.aws_lb_listener_main_arn
  aws_security_group_alb_id = dependency.common.outputs.aws_security_group_alb_id
  aws_route53_zone_main_zone_id = dependency.common.outputs.aws_route53_zone_main_zone_id
  repository_url = dependency.common.outputs.repository_url
}
