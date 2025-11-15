variable "aws_region" {
  description = "Région AWS où les ressources seront créées"
  type        = string
  default     = "ca-central-1"
}

variable "aws_profile" {
  description = "Porifle AWS à utiliser pour la création des ressources"
  type        = string
  default     = null
}

variable "aws_assume_role_workload" {
  description = "Rôle à assumer pour le compte de travail"
  type        = string
  default     = null
}

variable "workload_account_type" {
  type        = string
  description = "Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod]"
}

variable "environment" {
  type        = string
  description = "Nom de l'environnement du système déployé."
}

variable "system" {
  type        = string
  description = "Nom du système déployé."
}

variable "is_central_services" {
  type        = bool
  description = "Indique si le déploiement concerne les services centraux."
}
  