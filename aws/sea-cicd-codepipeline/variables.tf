variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_codecommit_repository_default_branch" {
    type = string
    description = "Branch du repo AWS CodeCommit de la définition de l'image docker de l'application."
}

variable "aws_codecommit_repository_name" {
    type = string
    description = "Nom du repo AWS CodeCommit de la définition de l'image docker de l'application."  
}

variable "ecs_cluster_name" {
    type = string
    description = "Nom du cluster ECS"  
}

variable "ecs_service_name" {
    type = string
    description = "Nom du service ECS"  
}
