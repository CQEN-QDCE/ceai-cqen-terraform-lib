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
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optional: If using an SSO connection, specify the SSO profile name in the .aws/config file on the machine executing the deployment. | `string` | `"preprod-xroad"` | no |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | Region to create the cluster. | `string` | `"ca-central-1"` | no |
| <a name="input_db_admin_user"></a> [db\_admin\_user](#input\_db\_admin\_user) | Admin user name for the application. | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Database host. | `string` | n/a | yes |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Superuser password for the database. | `string` | n/a | yes |
| <a name="input_db_master_user"></a> [db\_master\_user](#input\_db\_master\_user) | Primary database user name. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database connection port. | `number` | `5432` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Application database user name. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Unique identifier for the RDS resource. | `string` | `"keycloak"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name. | `string` | `"xroad"` | no |

## Outputs

No outputs.
