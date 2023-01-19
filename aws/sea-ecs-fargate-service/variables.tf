variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
}

variable "sea_network" {
  description = "Données du module sea-network (module.sea_network.all)"
}

variable "ecs_cluster_id" {
  description = "Identifiant du cluster ECS qui héberge le service"
}

variable "task_definition" {
  description = "Définition json de la tâche du service"
}

variable "task_port" {
  description = "Port utilisé par le conteneur du service"
}

variable "task_protocol" {
  description = "Protocol utilisé par le conteneur du service"
}

variable "task_vcpu" {
  description = "Nombre d'unités vCPU maximum alloué à une instance de tâche. https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html#task_size"
}

variable "task_memory" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
}

variable task_count {
  description = "Nombre minimal d'instance."
}

variable "task_healthcheck_path" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
}

variable "task_healthcheck_protocol" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
}

variable "internal_endpoint_port" {
  description = "Port sur lequel est exposé le endpoint interne du service."
  default = 443
}

variable "internal_endpoint_protocol" {
  description = "Protocol utilisé par le endpoint interne du service."
  default = "HTTPS"
}

variable "volume_efs" {
  description = "Volumes EFS à créer et attacher à la tâche."
  type        = any
  default     = {}
}