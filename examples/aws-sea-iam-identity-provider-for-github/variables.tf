variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/config du poste qui exécute le déploiement"
}

variable "system" {
  type = string
  description = "Nom du système déployé."
  default = "Exemple"
}

variable "environment" {
  type = string
  description = "Nom de l'environnement du système déployé."
}

variable "depot_github" {
  description = "Nom complet du dépôt Github (Organisation/depot)"
  type = string
}

variable "branche" {
  description = "Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS"
  type = string
}

variable "permissions_policies" {
  description = "Liste des noms des politiques de permissions à attacher au rôle du fournisseur"
  type = list(string)
}
