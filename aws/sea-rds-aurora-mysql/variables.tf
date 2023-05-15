variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "sea_network" {
  description = "Données du module sea-network"
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

variable "vpc_db_security_group_id" {
  description = "Une groupe de sécurité supplémentaire associé à RDS"
  type = string
}

variable "engine_version" {
  description = "La version du moteur de la base de données."
  type = string
  default = "8.0.mysql_aurora.3.03.0"
}