variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "depots_github" {
  description = "Nom complet des dépôts Github autorisé à assumer le rôle AWS (Organisation/depot)"
  type = list(string)
}

variable "branche" {
  description = "Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS (dev/test/prod)"
  type = string
}

variable "permissions_policies" {
  description = "Liste des noms des politiques de permissions à attacher au rôle AWS"
  type = list(string)
}