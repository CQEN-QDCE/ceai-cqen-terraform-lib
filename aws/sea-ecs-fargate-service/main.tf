locals {
  name = "${var.identifier}-ecs-service"
}

#-------------------------------------------------------------------------------
# Application load balancer
data "aws_caller_identity" "current" {}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${local.name}-tg"
  port     = var.internal_endpoint_port
  protocol = var.internal_endpoint_protocol
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
  name            = "${local.name}-alb"
  internal        = true
  subnets         = var.sea_network.app_subnets.ids
  security_groups = [var.sea_network.app_security_group.id]
  access_logs {
    bucket  = var.sea_network.elb_access_log_bucket_name
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
  certificate_arn = var.internal_endpoint_protocol == "HTTPS" ? var.sea_network.default_internal_ssl_certificate.arn : null
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
  name        = "${local.name}-TaskExecPolicy"
  description = "Policy pour execution task ECS"
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
  name  = "${local.name}-TaskExecRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy_doc.json
  path               = "/${var.identifier}/"
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${local.name}-TaskExecAttachement"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.policy.arn
}

#-------------------------------------------------------------------------------
# EFS

resource "aws_efs_file_system" "efs_fs" {
  for_each    = var.volume_efs

  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags             = {
      Name = each.value.name
  }
}

resource "aws_efs_access_point" "efs_ap" {
  for_each = aws_efs_file_system.efs_fs

  file_system_id = each.value.id
  tags = {
      Name = each.value.tags_all.Name
      file_system_id = each.value.id
  }
}

#-------------------------------------------------------------------------------
# Task Definition

resource "aws_ecs_task_definition" "app_task" {
  family                   = "${local.name}-tasks"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_vcpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = var.task_definition

  dynamic "volume" {
    for_each = aws_efs_access_point.efs_ap
    content {
      name = volume.value.tags.Name

      efs_volume_configuration {
        file_system_id          = volume.value.file_system_id
        transit_encryption      = "ENABLED"

        authorization_config {
          access_point_id = volume.value.id
          iam             = "ENABLED"
        }
      }

    }
  }

  #depends_on = [ aws_secretsmanager_secret_version.passbolt_app_secret ]
}

#-------------------------------------------------------------------------------
# ECS service

/* Retrouve la version de la tâche la plus récente */
data "aws_ecs_task_definition" "app_task" {
  task_definition = aws_ecs_task_definition.app_task.family
  depends_on = [aws_ecs_task_definition.app_task]
}

resource "aws_ecs_service" "app_service" {
  name                               = local.name
  cluster                            = var.ecs_cluster.cluster_id
  task_definition                    = "${aws_ecs_task_definition.app_task.family}:${max("${aws_ecs_task_definition.app_task.revision}", "${data.aws_ecs_task_definition.app_task.revision}")}"
  desired_count                      = var.task_minimum_count
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
    container_name   = var.task_container_name
    container_port   = var.task_port
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
  depends_on = [ aws_iam_role.ecs_task_execution_role, aws_ecs_task_definition.app_task, aws_lb_listener.alb_listener, aws_lb.alb, aws_lb_target_group.alb_tg ]
}

#-------------------------------------------------------------------------------
# Autoscaling

resource "aws_appautoscaling_target" "ecs_scaling_target" {
  max_capacity       = var.task_maximum_count
  min_capacity       = var.task_minimum_count
  resource_id        = "service/${var.ecs_cluster.cluster_name}/${aws_ecs_service.app_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_scaling_policy_cpu" {
  name               = "${local.name}-cpu-autoscaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.task_cpu_target_use
  }
}

resource "aws_appautoscaling_policy" "ecs_scaling_policy_memory" {
  name               = "${local.name}-memory-autoscaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.task_cpu_target_use
  }
}
