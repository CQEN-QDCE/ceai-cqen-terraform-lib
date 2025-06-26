variable "identifier" {
  description = "Identifiant unique pour la ressource RDS."
  type        = string
  default     = "keycloak"
}

variable "project_name" {
  description = "Nom du projet."
  type        = string
  default     = ""
}

variable "cluster_region" {
  description = "Région où créer le cluster."
  type        = string
  default     = "ca-central-1"
}

variable "aws_profile" {
  type        = string
  description = "Optionnel : Si vous utilisez une connexion SSO, spécifiez le nom du profil SSO dans le fichier .aws/config sur la machine exécutant le déploiement."
  default     = null
}

variable "db_master_user" {
  description = "Nom d'utilisateur principal de la base de données."
  type        = string
}

variable "db_user" {
  description = "Nom d'utilisateur de l'application pour la base de données."
  type        = string
}

variable "db_admin_user" {
  description = "Nom d'utilisateur administrateur pour l'application."
  type        = string
}

variable "db_host" {
  description = "Hôte de la base de données."
  type        = string
}

variable "db_master_password" {
  description = "Mot de passe superutilisateur pour la base de données."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Port de connexion à la base de données."
  type        = number
  default     = 5432
}