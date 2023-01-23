# SEA-ECS-Cluster

Crée un service ECS Fargate pouvant déployer une tâche conteneurisée

## Ressources créées

* aws_lb_target_group
* aws_lb
* aws_lb_listener
* aws_iam_policy
* aws_iam_role
* aws_iam_policy_attachment
* aws_efs_file_system (Si nécéssaire)
* aws_efs_access_point (Si nécéssaire)
* aws_ecs_task_definition
* aws_ecs_service

## Variables

| Nom | Description |
| --- | ----------- |
| identifier | Nom unique pour identifier les ressources AWS |
| sea_network | Données du module sea-network (module.sea_network.all) |
| ecs_cluster_id | Identifiant du cluster ECS qui héberge le service |
| task_definition | Définition json de la tâche du service |
| task_port | Port utilisé par le conteneur du service |
| task_protocol | Protocol utilisé par le conteneur du service |
| task_vcpu | Nombre d'unités vCPU maximum alloué à une instance de tâche. https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html#task_size" |
| task_memory | Quantité de GB de mémoire maximum alloué à une instance de tâche. |
| task_count | Nombre minimal d'instance. |
| task_healthcheck_path | Quantité de GB de mémoire maximum alloué à une instance de tâche. |
| task_healthcheck_protocol | Quantité de GB de mémoire maximum alloué à une instance de tâche. |
| internal_endpoint_port | Port sur lequel est exposé le endpoint interne du service. (default = 443) |
| internal_endpoint_protocol | Protocol utilisé par le endpoint interne du service. (default = "HTTPS") |
| volume_efs | Volumes EFS à créer et attacher à la tâche sous forme de map contenant un nom (name) et un chemin (mount_path). (default = {}) |


## Data sources 

| Nom | Description |
| --- | ----------- |
| ecs_service_id | Identifiant du service ECS |
| ecs_task_definition_id | Identifiant de la tâche ECS |
| ecs_task_definition_arn | ARN de la tâche ECS |
| alb_endpoint | DNS Interne du ALB exposant le service ECS |
