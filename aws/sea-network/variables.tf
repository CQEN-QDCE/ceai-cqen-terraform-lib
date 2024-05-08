variable "aws_profile" {
  type        = string
  description = "Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement"
  nullable    = true
  default     = null
}

variable "workload_account_type" {
  type        = string
  description = "Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod]"
}