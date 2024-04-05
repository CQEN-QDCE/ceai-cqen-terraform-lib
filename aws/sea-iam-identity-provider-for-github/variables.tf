variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
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