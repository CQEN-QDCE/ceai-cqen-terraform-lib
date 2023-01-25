variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "sea_network" {
  description = "Données du module sea-network (module.sea_network.all)"
}

variable "db_name" {
  description = "Nom de la base de données à créer."
  type = string
}

variable "db_user" {
  description = "Nom d'utilisateur de l'usager ayant droit sur la base de données"
  type = string
}

variable "min_capacity" {
  description = "Capacité minimale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM)"
  type = number
}

variable "max_capacity" {
  description = "Capacité minimale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM)"
  type = number
}

variable "allocated_storage" {
  description = "Quantité de stockage réservé à la création (GB)"
  type = number
}

variable "max_allocated_storage" {
  description = "Quantité de stockage maximum pouvant être réservé en cas de mise à l'échelle du stockage (GB)"
  type = number
}
