output "cluster_arn" {
    value = aws_ecs_cluster.cluster.arn
    description = "ARN du cluster ECS"
}