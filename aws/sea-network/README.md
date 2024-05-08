# SEA-Network

Récupère les ressources réseautique du compte de travail spécifié et les exporte dans des *data sources*.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.default_internal_ssl_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_security_group.app_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_security_group.data_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_security_group.web_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnet.app_subnet_a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.app_subnet_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.data_subnet_a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.data_subnet_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.web_subnet_a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.web_subnet_b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.app_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.data_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.web_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.shared_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [external_external.config_rule_elb_logging_enabled](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.config_rule_s3_bucket_encryption_enabled](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement | `string` | `null` | no |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_security_group"></a> [app\_security\_group](#output\_app\_security\_group) | Groupe de sécurité partagé App |
| <a name="output_app_subnet_a"></a> [app\_subnet\_a](#output\_app\_subnet\_a) | Subnet partagé App zone a |
| <a name="output_app_subnet_b"></a> [app\_subnet\_b](#output\_app\_subnet\_b) | Subnet partagé App zone b |
| <a name="output_app_subnets"></a> [app\_subnets](#output\_app\_subnets) | Subnet partagé App |
| <a name="output_data_security_group"></a> [data\_security\_group](#output\_data\_security\_group) | Groupe de sécurité partagé Data |
| <a name="output_data_subnet_a"></a> [data\_subnet\_a](#output\_data\_subnet\_a) | Subnet partagé Data zone a |
| <a name="output_data_subnet_b"></a> [data\_subnet\_b](#output\_data\_subnet\_b) | Subnet partagé Data zone b |
| <a name="output_data_subnets"></a> [data\_subnets](#output\_data\_subnets) | Subnet partagé Data |
| <a name="output_default_internal_ssl_certificate"></a> [default\_internal\_ssl\_certificate](#output\_default\_internal\_ssl\_certificate) | Certificat SSL interne par défaut du compte |
| <a name="output_elb_access_log_bucket_name"></a> [elb\_access\_log\_bucket\_name](#output\_elb\_access\_log\_bucket\_name) | Nom du bucket S3 où déposer les logs d'accès des ELB pour satisfaire la règle AWS Config :ELB\_LOGGING\_ENABLED |
| <a name="output_s3_kms_encryption_key_arn"></a> [s3\_kms\_encryption\_key\_arn](#output\_s3\_kms\_encryption\_key\_arn) | Arn de la clé KMS pour encrypter un bucket S3 pour satisfaire la règle AWS Config :S3\_BUCKET\_SERVER\_SIDE\_ENCRYPTION\_ENABLED |
| <a name="output_shared_vpc"></a> [shared\_vpc](#output\_shared\_vpc) | VPC partagé du compte de travail |
| <a name="output_web_security_group"></a> [web\_security\_group](#output\_web\_security\_group) | Groupe de sécurité partagé Web |
| <a name="output_web_subnet_a"></a> [web\_subnet\_a](#output\_web\_subnet\_a) | Subnet partagé Web zone a |
| <a name="output_web_subnet_b"></a> [web\_subnet\_b](#output\_web\_subnet\_b) | Subnet partagé Web zone b |
| <a name="output_web_subnets"></a> [web\_subnets](#output\_web\_subnets) | Subnet partagé Web |
