## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_postgresql.admindb"></a> [postgresql.admindb](#provider\_postgresql.admindb) | ~> 1.22.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.user_db_app_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.user_db_app_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [postgresql_database.app_db](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/database) | resource |
| [postgresql_grant.db_app_admin](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.db_app_user](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_role.admin_user_role](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [postgresql_role.user_role](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [random_password.admin_db_app_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.user_db_app_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.secret_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_admin_user"></a> [db\_admin\_user](#input\_db\_admin\_user) | Nom d'utilisateur administrateur de la base de données applicative. | `string` | n/a | yes |
| <a name="input_db_app_name"></a> [db\_app\_name](#input\_db\_app\_name) | Nom de la base de données applicative. | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Endpoint de la base de données. | `string` | n/a | yes |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Mot de passe maître de la base de données. | `string` | n/a | yes |
| <a name="input_db_master_user"></a> [db\_master\_user](#input\_db\_master\_user) | Nom d'utilisateur maître de la base de données. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port de connexion à la base de données. | `number` | `5432` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Nom d'utilisateur de la base de données applicative. | `string` | n/a | yes |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optionnel) Le moteur de la base de données. | `string` | `"aurora-postgresql"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_admin_user"></a> [db\_admin\_user](#output\_db\_admin\_user) | Nom d'utilisateur administrateur de la base de données. |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Nom de la base de données créée. |
| <a name="output_db_user"></a> [db\_user](#output\_db\_user) | Nom d'utilisateur de la base de données. |
| <a name="output_user_db_secret_arn"></a> [user\_db\_secret\_arn](#output\_user\_db\_secret\_arn) | ARN du secret utilisateur dans AWS Secrets Manager. |
