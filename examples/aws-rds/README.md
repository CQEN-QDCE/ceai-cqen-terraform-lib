<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora-mysql"></a> [aurora-mysql](#module\_aurora-mysql) | ./.terraform/modules/ceai_lib/aws/sea-rds | n/a |
| <a name="module_aurora-postgresql"></a> [aurora-postgresql](#module\_aurora-postgresql) | ./.terraform/modules/ceai_lib/aws/sea-rds | n/a |
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | github.com/CQEN-QDCE/ceai-cqen-terraform-lib | feature/sea-rds |
| <a name="module_sea_network"></a> [sea\_network](#module\_sea\_network) | ./.terraform/modules/ceai_lib/aws/sea-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement du système déployé. | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Nom du système déployé. | `string` | `"Exemple"` | no |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->