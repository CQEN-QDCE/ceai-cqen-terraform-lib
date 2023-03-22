output "ecs_service_id" {
    value = aws_ecs_service.app_service.id
    description = "Identifiant du service ECS"
}

output "ecs_task_definition_id" {
    value = aws_ecs_task_definition.app_task.id
    description = "Identifiant de la tâche ECS"
}

output "ecs_task_definition_arn" {
    value = aws_ecs_task_definition.app_task.arn
    description = "ARN de la tâche ECS"
}

output "alb_endpoint" {
    value = aws_lb.alb.dns_name
    description = "DNS Interne du ALB exposant le service ECS"
}