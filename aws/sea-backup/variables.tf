variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_profile" {
  type = string
  description = "Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement"
  nullable = true
  default = null
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

variable "ressources_arn" {
  description = "Liste d'ARN des ressources à inclure dans la sélection de sauvegarde"
  type        = list(string)
}