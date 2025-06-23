<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| postgresql | n/a |
| aws | n/a |
| random | n/a |

## Resources

| Name | Type |
|------|------|
| postgresql_database.app_db | resource |
| postgresql_role.user_role | resource |
| postgresql_grant.db_app_user | resource |
| aws_secretsmanager_secret.user_db_app_secret | resource |
| aws_secretsmanager_secret_version.user_db_app_secret | resource |
| random_password.user_db_app_password | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| identifier | Préfixe unique pour identifier les ressources de l'application. | `string` | n/a | yes |
| db_user | Nom d'utilisateur à créer dans la base de données. | `string` | n/a | yes |
| db_app_name | Nom de la base de données cible (créée par le module). | `string` | n/a | yes |
| db_host | Endpoint de la base de données. | `string` | n/a | yes |
| db_port | Port de connexion à la base de données. | `number` | 5432 | no |
| db_master_user | Nom d'utilisateur maître de la base de données. | `string` | n/a | yes |
| db_master_password | Mot de passe maître de la base de données. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db_user | Nom d'utilisateur créé dans la base de données. |
| user_db_secret_arn | ARN du secret utilisateur dans AWS Secrets Manager. |
| user_db_password | Mot de passe généré pour l'utilisateur. |
<!-- END_TF_DOCS -->

## Fonctionnalités

- Crée une base de données PostgreSQL
- Crée un utilisateur PostgreSQL avec mot de passe généré
- Attribue les droits nécessaires à l'utilisateur sur la base
- Stocke les identifiants dans AWS Secrets Manager