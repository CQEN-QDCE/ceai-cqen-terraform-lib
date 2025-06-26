# Exemple: AWS RDS Aurora PostgreSQL

Voici un exemple sur la gestion des utilisateurs pour une base de données AWS RDS Aurora PostgreSQL. Il permet de créer et de configurer les utilisateurs nécessaires à une application, en utilisant des variables pour personnaliser les noms d’utilisateurs, mots de passe et autres paramètres liés à la base de données. Ce module est conçu pour être utilisé dans un environnement AWS, avec la possibilité de spécifier le profil AWS, la région, et d’autres options de configuration.  

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | github.com/CQEN-QDCE/ceai-cqen-terraform-lib | feature/users-postgres |
| <a name="module_db_users_postgres"></a> [db\_users\_postgres](#module\_db\_users\_postgres) | ./.terraform/modules/ceai_lib/aws/sea-users-rds-postgres | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optionnel : Si vous utilisez une connexion SSO, spécifiez le nom du profil SSO dans le fichier .aws/config sur la machine exécutant le déploiement. | `string` | `null` | no |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | Région où créer le cluster. | `string` | `"ca-central-1"` | no |
| <a name="input_db_admin_user"></a> [db\_admin\_user](#input\_db\_admin\_user) | Nom d'utilisateur administrateur pour l'application. | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Hôte de la base de données. | `string` | n/a | yes |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Mot de passe superutilisateur pour la base de données. | `string` | n/a | yes |
| <a name="input_db_master_user"></a> [db\_master\_user](#input\_db\_master\_user) | Nom d'utilisateur principal de la base de données. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port de connexion à la base de données. | `number` | `5432` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Nom d'utilisateur de l'application pour la base de données. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifiant unique pour la ressource RDS. | `string` | `"keycloak"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Nom du projet. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->