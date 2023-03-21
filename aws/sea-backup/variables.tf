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

variable "backup_rds_create" {
    type = bool
    description = "Si la variable est fausse, nous ne créons pas de sauvegarde pour RDS en fixant le paramètre count à false."
    default = false
}

variable "backup_efs_create" {
    type = bool
    description = "Si la variable est fausse, nous ne créons pas de sauvegarde pour EFS en fixant le paramètre count à false."
    default = false
}

variable "backup_efs_tag" {
    type = string
    description = "Le tag des efs qui ont besoin de la sauvegarde."
}