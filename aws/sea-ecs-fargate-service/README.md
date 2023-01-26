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
* aws_appautoscaling_target
* aws_appautoscaling_policy

## Variables

| Nom | Description |
| --- | ----------- |
| identifier | Nom unique pour identifier les ressources AWS |
| sea_network | Données du module sea-network |
| ecs_cluster_id | Identifiant du cluster ECS qui héberge le service |
| task_definition | Définition json de la tâche du service |
| task_port | Port utilisé par le conteneur du service |
| task_protocol | Protocol utilisé par le conteneur du service |
| task_vcpu | Nombre d'unités vCPU maximum alloué à une instance de tâche. https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html#task_size" |
| task_memory | Quantité de GB de mémoire maximum alloué à une instance de tâche. |
| task_minimum_count | Nombre minimum d'instance de la tâche à laquelle l'autoscaling peut abaisser. |
| task_maximum_count | Nombre maximum d'instance de la tâche à laquelle l'autoscaling peut augmenter. |
| task_cpu_target_use | Pourcentage idéal d'utlisation des ressources de calcul. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre. |
| task_memory_target_use | Pourcentage idéal d'utlisation de la mémoire. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre. |
| task_healthcheck_path | Url relative à vérifier pour effectuer un healthcheck. Cette url doit renvoyer un code de réponse HTTP 200 OK si le service fonctionne. |
| task_healthcheck_protocol | Protocole à utiliser pour le healthcheck. (defaut HTTP) |
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
