output "cluster_arn" {
    value = aws_ecs_cluster.cluster.arn
    description = "ARN du cluster ECS"
}

output "cluster_id" {
    value = aws_ecs_cluster.cluster.id
    description = "Identifiant du cluster ECS"
}