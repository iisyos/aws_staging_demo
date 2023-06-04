resource "aws_lb_listener_rule" "main" {
  listener_arn = var.aws_lb_listener_main_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.id
  }

  condition {
    host_header {
      values = ["${var.environment}.${var.domain}"]
    }
  }
}

resource "aws_lb_target_group" "main" {
  name = "${var.app_name}-${var.environment}"

  vpc_id = var.vpc_id

  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    port     = 3000
    path     = "/"
    interval = 5 * 60
    timeout  = 2 * 60
  }
}