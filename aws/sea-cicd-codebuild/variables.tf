variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "app_name" {
  type = string
  description = "Nom de l'application."
}

variable "account_id" {
  type = string
  description = "AWS account ID."
}

variable "app_ecr_repository_name" {
  type = string
  description = "Nom du repo AWS ECR de l'image docker de l'application."
}
  
variable "app_ecs_container_name" {
  type = string
  description = "Nom du container AWS ECS de l'application."  
}

variable "github_repo_url" {
  type = string
  description = "URL du repo GitHub de l'application."
}
  
variable "github_repo_branch" {
  type = string
  description = "Branch du repo GitHub de l'application."  
}

variable "app_buildspec_path" {
  type = string
  description = "Path du fichier buildspec de l'application dans le repo GitHub."  
}

variable "app_path" {
  type = string
  description = "Path de l'application dans le repo GitHub."
}  