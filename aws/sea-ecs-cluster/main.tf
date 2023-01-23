locals {
  name = "${var.identifier}-ecs-cluster"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.name}"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}