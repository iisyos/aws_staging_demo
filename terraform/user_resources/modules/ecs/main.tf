locals {
  load_balancer = ["${var.aws_lb_target_group_main_arn}"]
}

resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.environment}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "MyEcsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_ecs_task_definition" "main" {
  family = "${var.app_name}-${var.environment}"

  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<EOL
[
  {
    "name": "${var.app_name}-${var.environment}",
    "image": "${var.image_url}",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOL
}

resource "aws_security_group" "ecs" {
  name        = "${var.app_name}-${var.environment}-ecs"
  description = "${var.app_name} ${var.environment} ecs"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-ecs"
  }
}

resource "aws_security_group_rule" "ecs" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  source_security_group_id = var.aws_security_group_alb_id
}

resource "aws_ecs_service" "main" {
  name = "${var.app_name}-${var.environment}"

  cluster = aws_ecs_cluster.main.name

  launch_type = "FARGATE"

  desired_count = "1"

  task_definition = aws_ecs_task_definition.main.arn

  depends_on = [aws_ecs_task_definition.main]

  network_configuration {
    assign_public_ip = true
    subnets          = ["${var.public_a_id}", "${var.public_c_id}"]
    security_groups  = ["${aws_security_group.ecs.id}"]
  }

  dynamic "load_balancer" {
    for_each = local.load_balancer
    content {
      target_group_arn = load_balancer.value
      container_name   = "${var.app_name}-${var.environment}"
      container_port   = 80
    }
  }
}
