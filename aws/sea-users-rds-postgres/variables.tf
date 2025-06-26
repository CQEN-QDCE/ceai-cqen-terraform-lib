variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type        = string
}

variable "engine" {
  description = "(Optionnel) Le moteur de la base de données."
  type        = string
  default     = "aurora-postgresql"
}

variable "db_user" {
  description = "Nom d'utilisateur de la base de données applicative."
  type        = string
  sensitive   = true
}

variable "db_admin_user" {
  description = "Nom d'utilisateur administrateur de la base de données applicative."
  type        = string
  sensitive   = true
}

variable "db_master_user" {
  description = "Nom d'utilisateur maître de la base de données."
  type        = string
  sensitive   = true
}

variable "db_master_password" {
  description = "Mot de passe maître de la base de données."
  type        = string
  sensitive   = true
}

variable "db_app_name" {
  description = "Nom de la base de données applicative."
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Endpoint de la base de données."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Port de connexion à la base de données."
  type        = number
  default     = 5432
}

