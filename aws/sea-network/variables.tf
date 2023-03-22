variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement"
}

variable "workload_account_type" {
  type = string
  description = "Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod]"
}