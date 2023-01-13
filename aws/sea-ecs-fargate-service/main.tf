locals {
  name = "${var.identifier}"
}


#-------------------------------------------------------------------------------
# Application load balancer
data "aws_caller_identity" "current" {}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${local.name}"
  port     = var.task_port
  protocol = var.task_protocol
  vpc_id   = var.sea_network.shared_vpc.id
  target_type = "ip"
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    enabled             = true
    interval            = 30
    path                = var.task_healthcheck_path
    protocol            = var.task_healthcheck_protocol
    timeout             = 10
    healthy_threshold   = 5
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_lb" "alb" {
  name            = "${local.name}"
  internal        = true
  subnets         = var.sea_network.app_subnets.ids
  security_groups = [var.sea_network.app_security_group.id]
  access_logs {
    bucket  = "${local.name}-internal-alb-access-logs"
    prefix  = "${data.aws_caller_identity.current.account_id}/elb-${local.name}-alb"
    enabled = true
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn  = aws_lb.alb.arn
  port               = var.internal_endpoint_port
  protocol           = var.internal_endpoint_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

#-------------------------------------------------------------------------------
# IAM
data "aws_iam_policy_document" "ecs_task_execution_role_policy_doc" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
} 

resource "aws_iam_policy" "policy" {
  name        = "${local.name}-EcsTaskExecPolicy"
  description = "A ecs task policy"
  policy      =  <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:DescribeLogStreams",                
                "logs:PutLogEvents",
                "ssm:GetParameters",
                "secretsmanager:GetSecretValue",
                "ecr:PutReplicationConfiguration",
                "ecr:PutRegistryScanningConfiguration",
                "ecr:GetRegistryScanningConfiguration",
                "ecr:GetRegistryPolicy",
                "ecr:GetAuthorizationToken",
                "ecr:DescribeRegistry",
                "ecr:DescribePullThroughCacheRules",
                "ecr:DeletePullThroughCacheRule",
                "ecr:CreatePullThroughCacheRule",
                "ecr:BatchGetImage", 
                "ecr:BatchCheckLayerAvailability", 
                "ecr:CompleteLayerUpload", 
                "ecr:GetDownloadUrlForLayer"                         
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name  = "${local.name}-EcsTaskExecRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy_doc.json
  path               = "/${var.identifier}/"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${local.name}-EcsTaskExecAttachement"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.policy.arn
}

#-------------------------------------------------------------------------------
# Task Definition

resource "aws_ecs_task_definition" "app_task" {
  family                   = local.name
  container_definitions    = var.task_definition
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_vcpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  #depends_on = [ aws_secretsmanager_secret_version.passbolt_app_secret ] TODO
}

#-------------------------------------------------------------------------------
# ECS service

/* Retrouve la version de la tâche la plus récente */
data "aws_ecs_task_definition" "app_task" {
  task_definition = aws_ecs_task_definition.app_task.family
  depends_on = [aws_ecs_task_definition.app_task]
}

resource "aws_ecs_service" "app_service" {
  name                               = "${local.name}"
  cluster                            = var.ecs_cluster_id
  task_definition                    = "${aws_ecs_task_definition.app_task.family}:${max("${aws_ecs_task_definition.app_task.revision}", "${data.aws_ecs_task_definition.app_task.revision}")}"
  desired_count                      = var.task_count
  deployment_minimum_healthy_percent = 0
  launch_type                        = "FARGATE"
  force_new_deployment               = true
  network_configuration {
     subnets         = var.sea_network.app_subnets.ids
     security_groups = [var.sea_network.app_security_group.id]
     assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = "${local.name}"
    container_port   = var.internal_endpoint_port
  }
  depends_on = [ aws_iam_role.ecs_task_execution_role, aws_ecs_task_definition.app_task, aws_lb_listener.alb_listener, aws_lb.alb, aws_lb_target_group.alb_tg ]
}
