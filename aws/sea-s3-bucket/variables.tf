variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type        = string
}

variable "sea_network" {
  description = "Données du module sea-network"
}

variable "name" {
  description = "Nom du bucket"
  type        = string
}

variable "bucket_policy" {
  description = "Politique de sécurité S3 au format json limitant l'accès aux bucket via un des mécanismes suivants: utilisateurs fédérés, par mandataires de service, par adresses IP ou par VPC"
  type        = string
}