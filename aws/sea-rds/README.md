<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.95.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.rds_monitoring_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rds_monitoring_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_rds_cluster.rds_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.rds_cluster_instance_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_instance.rds_cluster_instance_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_secretsmanager_secret.rds_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.rds_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.monitoring_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Nom de la base de données à créer. | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Nom d'utilisateur de l'usager ayant droit sur la base de données | `string` | n/a | yes |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optionnel) Le moteur de la base de données. | `string` | `"aurora-mysql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | (Optionnel) Le mode du moteur de la base de données. | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optionnel) La version du moteur de la base de données. | `string` | `"8.0.mysql_aurora.3.04"` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Capacité maximale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM) | `number` | n/a | yes |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Capacité minimale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM) | `number` | n/a | yes |
| <a name="input_sea_network"></a> [sea\_network](#input\_sea\_network) | Données du module sea-network | `any` | n/a | yes |
| <a name="input_vpc_db_additional_security_group_ids"></a> [vpc\_db\_additional\_security\_group\_ids](#input\_vpc\_db\_additional\_security\_group\_ids) | (Optionnel) Identifiants de groupes de sécurité supplémentaire associé à RDS | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_rds_arn"></a> [cluster\_rds\_arn](#output\_cluster\_rds\_arn) | ARN du cluster  dans RDS |
| <a name="output_cluster_rds_id"></a> [cluster\_rds\_id](#output\_cluster\_rds\_id) | Id du cluster  dans RDS |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Nom de la base de donnée créée |
| <a name="output_db_password_secret"></a> [db\_password\_secret](#output\_db\_password\_secret) | Référence vers le secret contenant le mot de passe administrateur de la base de donnée |
| <a name="output_db_user_secret"></a> [db\_user\_secret](#output\_db\_user\_secret) | Référence vers le secret contenant le nom d'usager administrateur de la base de donnée |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Point de terminaison du cluster dans RDS |
| <a name="output_rds_cluster_instance"></a> [rds\_cluster\_instance](#output\_rds\_cluster\_instance) | La ressource aws pour voir si l'instance  est bien déployée |
| <a name="output_rds_db_pass"></a> [rds\_db\_pass](#output\_rds\_db\_pass) | Le mot de passe administrateur de la base de donnée |
<!-- END_TF_DOCS -->

## À venir

:warning: TODO! Afin de supporter les appels existants vers le module sea-rds-aurora-mysql qui ne sera plus maintenu et qui devrait être remplacé par ce module-ci (sea-rds), ajuster les scripts du sea-rds-aurora-mysql pour qu'il soit fonctionnel avec le module sea-rds. 