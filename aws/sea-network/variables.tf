variable "aws_profile" {
  type        = string
  description = "Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement"
  nullable    = true
  default     = null
}

variable "workload_account_type" {
  type        = string
  description = "Type logique de compte de travail ASEA [Sandbox, Dev, Prod]"
}

variable "network_workload_prefix" {
  type        = string
  description = "Préfixe utilisé pour résoudre les ressources réseau AWS; si null, workload_account_type est utilisé"
  default     = null
  nullable    = true
}
