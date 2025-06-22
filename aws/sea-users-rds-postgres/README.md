<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | 5.95.0 |
| random | 3.7.2 |
| postgresql | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| aws_kms_key.rds | data source |
| random_password.admin_db_password | resource |
| random_password.user_db_password | resource |
| aws_secretsmanager_secret.user_db_secret | resource |
| aws_secretsmanager_secret_version.user_db_secret | resource |
| postgresql_database.app_db | resource |
| postgresql_role.admin_user_role | resource |
| postgresql_role.user_role | resource |
| postgresql_grant_role.db_app_admin | resource |
| postgresql_grant.db_app_user | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| identifier | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| engine | (Optionnel) Le moteur de la base de données. | `string` | n/a | yes |
| db_user | Nom d'utilisateur de la base de données. | `string` | n/a | yes |
| db_admin_user | Nom d'utilisateur administrateur de la base de données. | `string` | n/a | yes |
| db_app_name | Nom de la base de données applicative. | `string` | n/a | yes |
| db_host | Hôte de la base de données. | `string` | n/a | yes |
| db_port | Port de connexion à la base de données. | `number` | n/a | yes |
| db_master_user | Nom d'utilisateur maître de la base de données. | `string` | n/a | yes |
| db_master_password | Mot de passe maître de la base de données. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db_name | Nom de la base de données créée. |
| db_user | Nom d'utilisateur de la base de données. |
| db_admin_user | Nom d'utilisateur administrateur de la base de données. |
| user_db_secret_arn | ARN du secret utilisateur dans AWS Secrets Manager. |
<!-- END_TF_DOCS --> 