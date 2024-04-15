# Exemple d'un déploiement ECS - RDS Aurora

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | github.com/CQEN-QDCE/ceai-cqen-terraform-lib | dev |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ./.terraform/modules/ceai_lib/aws/sea-ecs-cluster | n/a |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | ./.terraform/modules/ceai_lib/aws/sea-ecs-fargate-service | n/a |
| <a name="module_mysql"></a> [mysql](#module\_mysql) | ./.terraform/modules/ceai_lib/aws/sea-rds-aurora-mysql | n/a |
| <a name="module_sea_network"></a> [sea\_network](#module\_sea\_network) | ./.terraform/modules/ceai_lib/aws/sea-network | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.container_test](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement du système déployé. | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Nom du système déployé. | `string` | `"Exemple"` | no |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

No outputs.
