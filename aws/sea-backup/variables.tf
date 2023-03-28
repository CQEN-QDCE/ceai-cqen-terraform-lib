variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement"
}

variable "backup_alarms_email" {
    type = string
    description = "Courriel pour les alertes de sauvegarde en cas de défaillance"
}

variable "backup_rules" {
    type = list(object({
      name                     = string
      schedule                 = string
      start_window             = number
      completion_window        = number
      delete_after             = number
      enable_continuous_backup = bool
    }))
    description = "L'objet règle qui spécifie une tâche planifiée utilisée pour sauvegarder une sélection de ressources."
}

variable "backup_ressources_arn" {
  description = "Liste d'ARN des ressources à inclure dans la sélection de sauvegarde"
  type        = list(string)
}