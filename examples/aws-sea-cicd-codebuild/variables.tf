variable "aws_profile" {
  type        = string
  description = "Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement"
  nullable    = true
  default     = null
}

variable "system" {
  type        = string
  description = "Nom du système déployé."
  default     = "Exemple"
}

variable "environment" {
  type        = string
  description = "Nom de l'environnement du sytème déployé."
}

variable "github_repo_url" {
  type        = string
  description = "URL du repo GitHub de l'application."
}

variable "github_repo_branch" {
  type        = string
  description = "Branch du repo GitHub de l'application."
}

variable "app_buildspec_path" {
  type        = string
  description = "Path du fichier buildspec de l'application dans le repo GitHub."
}

variable "app_name" {
  type        = string
  description = "Nom de l'application."
}

variable "app_path" {
  type        = string
  description = "Path de l'application dans le repo GitHub."
}
