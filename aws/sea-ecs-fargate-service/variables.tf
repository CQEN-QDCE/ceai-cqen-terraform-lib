variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "sea_network" {
  description = "Données du module sea-network (module.sea_network.all)"
}

variable "ecs_cluster_id" {
  description = "Identifiant du cluster ECS qui héberge le service"
  type = string
}

variable "task_definition" {
  description = "Définition json de la tâche du service"
  type = string
}

variable "task_port" {
  description = "Port utilisé par le conteneur du service"
  type = number
}

variable "task_protocol" {
  description = "Protocol utilisé par le conteneur du service"
  type = string
}

variable "task_vcpu" {
  description = "Nombre d'unités vCPU maximum alloué à une instance de tâche. https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html#task_size"
  type = string
}

variable "task_memory" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
  type = string
}

variable task_count {
  description = "Nombre minimal d'instance."
  type = string
}

variable "task_healthcheck_path" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
  type = string
}

variable "task_healthcheck_protocol" {
  description = "Quantité de GB de mémoire maximum alloué à une instance de tâche."
  type = string
}

variable "internal_endpoint_port" {
  description = "Port sur lequel est exposé le endpoint interne du service."
  type = number
  default = 443
}

variable "internal_endpoint_protocol" {
  description = "Protocol utilisé par le endpoint interne du service."
  type = string
  default = "HTTPS"
}

variable "volume_efs" {
  description = "Volumes EFS à créer et attacher à la tâche sous forme de map contenant un nom (name) et un chemin (mount_path)."
  type = map(object({
    name = string
    mount_path = string
  }))
  default     = {}
}