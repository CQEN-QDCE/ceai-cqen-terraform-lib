variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement"
}

variable "rds_arn" {
    type = string
    description = "Le nom de ressource Amazon (ARN) de RDS"
}

variable "backup_alarms_email" {
    type = string
    description = "Courriel pour les alertes de sauvegarde en cas de défaillance"
}

variable "backup_rules" {
    type = objet
    description = "L'objet règle qui spécifie une tâche planifiée utilisée pour sauvegarder une sélection de ressources."
}

variable "efs_arn" {
    type = string
    description = "La liste ARN de l'EFS"
}

variable "ressource_type" {
  type    = string
  default = "all"
  description = "Type de sauvegarde à créer (efs, rds, or all)"
  validation {
    condition = can(regex("^(efs|rds|all)$", var.ressource_type))
    error_message = "Type de sauvegarde non valide, ressource_type: '${var.ressource_type}'. Valeurs autorisées: efs, rds, all"
  }
}

variable "backup_efs_tag" {
    type = string
    description = "Le tag des efs qui ont besoin de la sauvegarde."
}