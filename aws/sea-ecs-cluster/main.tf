locals {
  name = "${var.identifier}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.name}"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}