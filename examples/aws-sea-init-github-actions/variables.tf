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

variable "system" {
  type        = string
  description = "Nom du système déployé."
  default     = "Exemple"
}

variable "environment" {
  type        = string
  description = "Nom de l'environnement du système déployé."
}

variable "depots_github" {
  description = "Liste de nom complet des dépôts Github (Organisation/depot) pouvant utiliser le IDP"
  type        = list(string)
}

variable "branche" {
  description = "Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS"
  type        = string
}

variable "permissions_policies" {
  description = "Liste des noms des politiques de permissions à attacher au rôle du fournisseur"
  type        = list(string)
}
