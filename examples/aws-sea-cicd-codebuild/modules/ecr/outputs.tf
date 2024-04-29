output "ecr_arn" {
    value = aws_ecr_repository.ecr_repo.arn
    description = "ARN du repo."  
}

output "ecr_name" {
    value = aws_ecr_repository.ecr_repo.name
    description = "Nom du repo."  
}

output "ecr_id" {
    value = aws_ecr_repository.ecr_repo.id
    description = "ID du repo."  
}

output "ecr_image_uri" {
    value = aws_ecr_repository.ecr_repo.repository_url
    description = "URI du repo."  
}