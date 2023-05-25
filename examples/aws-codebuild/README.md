<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | github.com/CQEN-QDCE/ceai-cqen-terraform-lib | dev |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/ecr | n/a |
| <a name="module_sea_cicd_codebuild"></a> [sea\_cicd\_codebuild](#module\_sea\_cicd\_codebuild) | ./.terraform/modules/ceai_lib/aws/sea-cicd-codebuild | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Nom du profil de connexion SSO dans le fichier .aws/config du poste qui exécute le déploiement | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement du sytème déployé. | `string` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Nom du système déployé. | `string` | `"Exemple"` | no |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->