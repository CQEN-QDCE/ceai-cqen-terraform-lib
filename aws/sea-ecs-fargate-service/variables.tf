variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "sea_network" {
  description = "Données du module sea-network"
}

variable "ecs_cluster" {
  description = "Données d'un module sea-ecs-cluster"
}

variable "task_definition" {
  description = "Définition json de la tâche du service"
  type = string
}

variable "task_container_name" {
  description = "Nom du conteneur à déployer dans le service. Doit être le même que spécifié au task_definition."
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

variable task_minimum_count {
  description = "Nombre minimum d'instance de la tâche à laquelle l'autoscaling peut abaisser."
  type = number
}

variable task_maximum_count {
  description = "Nombre maximum d'instance de la tâche à laquelle l'autoscaling peut augmenter."
  type = number
}

variable task_cpu_target_use {
  description = "Pourcentage idéal d'utlisation des ressources de calcul. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre."
  type = number
  default = 85
}

variable task_memory_target_use {
  description = "Pourcentage idéal d'utlisation de la mémoire. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre."
  type = number
  default = 85
}

variable "task_healthcheck_path" {
  description = "Url relative à vérifier pour effectuer un healthcheck. Cette url doit renvoyer un code de réponse HTTP 200 OK si le service fonctionne."
  type = string
}

variable "task_healthcheck_protocol" {
  description = "Protocole à utiliser pour le healthcheck. (defaut HTTP)"
  type = string
  default = "HTTP"
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