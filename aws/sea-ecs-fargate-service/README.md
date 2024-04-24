# SEA-ECS-Cluster

Crée un service ECS Fargate pouvant déployer une tâche conteneurisée

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_scaling_policy_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_scaling_policy_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_scaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_service.app_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.app_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_access_point.efs_ap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.efs_fs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.iam_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.alb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecs_task_definition.app_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_task_definition) | data source |
| [aws_iam_policy_document.ecs_task_execution_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | Données d'un module sea-ecs-cluster | `any` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_internal_endpoint_port"></a> [internal\_endpoint\_port](#input\_internal\_endpoint\_port) | Port sur lequel est exposé le endpoint interne du service. | `number` | `443` | no |
| <a name="input_internal_endpoint_protocol"></a> [internal\_endpoint\_protocol](#input\_internal\_endpoint\_protocol) | Protocol utilisé par le endpoint interne du service. | `string` | `"HTTPS"` | no |
| <a name="input_sea_network"></a> [sea\_network](#input\_sea\_network) | Données du module sea-network | `any` | n/a | yes |
| <a name="input_task_container_name"></a> [task\_container\_name](#input\_task\_container\_name) | Nom du conteneur à déployer dans le service. Doit être le même que spécifié au task\_definition. | `string` | n/a | yes |
| <a name="input_task_cpu_target_use"></a> [task\_cpu\_target\_use](#input\_task\_cpu\_target\_use) | Pourcentage idéal d'utilisation des ressources de calcul. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre. | `number` | `85` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | Définition json de la tâche du service | `string` | n/a | yes |
| <a name="input_task_healthcheck_path"></a> [task\_healthcheck\_path](#input\_task\_healthcheck\_path) | Url relative à vérifier pour effectuer un healthcheck. Cette url doit renvoyer un code de réponse HTTP 200 OK si le service fonctionne. | `string` | n/a | yes |
| <a name="input_task_healthcheck_protocol"></a> [task\_healthcheck\_protocol](#input\_task\_healthcheck\_protocol) | Protocole à utiliser pour le healthcheck. (defaut HTTP) | `string` | `"HTTP"` | no |
| <a name="input_task_maximum_count"></a> [task\_maximum\_count](#input\_task\_maximum\_count) | Nombre maximum d'instance de la tâche à laquelle l'autoscaling peut augmenter. | `number` | n/a | yes |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Quantité de GB de mémoire maximum alloué à une instance de tâche. | `string` | n/a | yes |
| <a name="input_task_memory_target_use"></a> [task\_memory\_target\_use](#input\_task\_memory\_target\_use) | Pourcentage idéal d'utilisation de la mémoire. L'autoscaling ajuste le nombre d'instance par rapport à ce nombre. | `number` | `85` | no |
| <a name="input_task_minimum_count"></a> [task\_minimum\_count](#input\_task\_minimum\_count) | Nombre minimum d'instance de la tâche à laquelle l'autoscaling peut abaisser. | `number` | n/a | yes |
| <a name="input_task_port"></a> [task\_port](#input\_task\_port) | Port utilisé par le conteneur du service | `number` | n/a | yes |
| <a name="input_task_protocol"></a> [task\_protocol](#input\_task\_protocol) | Protocol utilisé par le conteneur du service | `string` | n/a | yes |
| <a name="input_task_vcpu"></a> [task\_vcpu](#input\_task\_vcpu) | Nombre d'unités vCPU maximum alloué à une instance de tâche. https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html#task_size | `string` | n/a | yes |
| <a name="input_volume_efs"></a> [volume\_efs](#input\_volume\_efs) | Volumes EFS à créer et attacher à la tâche sous forme de map contenant un nom (name) et un chemin (mount\_path). | <pre>map(object({<br>    name = string<br>    mount_path = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_endpoint"></a> [alb\_endpoint](#output\_alb\_endpoint) | DNS Interne du ALB exposant le service ECS |
| <a name="output_alb_listener_arn"></a> [alb\_listener\_arn](#output\_alb\_listener\_arn) | ARN du listener du ALB exposant le service ECS |
| <a name="output_ecs_service_id"></a> [ecs\_service\_id](#output\_ecs\_service\_id) | Identifiant du service ECS |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | Nom du service ECS |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | ARN de la tâche ECS |
| <a name="output_ecs_task_definition_id"></a> [ecs\_task\_definition\_id](#output\_ecs\_task\_definition\_id) | Identifiant de la tâche ECS |
| <a name="output_ecs_task_volume_arn_list"></a> [ecs\_task\_volume\_arn\_list](#output\_ecs\_task\_volume\_arn\_list) | Liste des arn des volumes EFS créés |
