# SEA-Backup-RDS-EFS

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.backup_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.backup_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_selection.backup_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.backup_vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_backup_vault_notifications.backup_vault_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_notifications) | resource |
| [aws_iam_role.aws-backup-service-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.backup-service-aws-backup-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.backup-service-pass-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.restore-service-aws-backup-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_sns_topic.alert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.current_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_efs_file_system.data_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/efs_file_system) | data source |
| [aws_iam_policy.aws-backup-service-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.aws-restore-service-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.aws-backup-service-assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pass-role-policy-doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.aws_backup_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement | `string` | n/a | yes |
| <a name="input_backup_alarms_email"></a> [backup\_alarms\_email](#input\_backup\_alarms\_email) | Courriel pour les alertes de sauvegarde en cas de défaillance | `string` | n/a | yes |
| <a name="input_backup_efs_create"></a> [backup\_efs\_create](#input\_backup\_efs\_create) | Si la variable est fausse, nous ne créons pas de sauvegarde pour EFS en fixant le paramètre count à false. | `bool` | `false` | no |
| <a name="input_backup_efs_tag"></a> [backup\_efs\_tag](#input\_backup\_efs\_tag) | Le tag des efs qui ont besoin de la sauvegarde. | `string` | n/a | yes |
| <a name="input_backup_rds_create"></a> [backup\_rds\_create](#input\_backup\_rds\_create) | Si la variable est fausse, nous ne créons pas de sauvegarde pour RDS en fixant le paramètre count à false. | `bool` | `false` | no |
| <a name="input_backup_rules"></a> [backup\_rules](#input\_backup\_rules) | L'objet règle qui spécifie une tâche planifiée utilisée pour sauvegarder une sélection de ressources. | `objet` | n/a | yes |
| <a name="input_efs_arn"></a> [efs\_arn](#input\_efs\_arn) | La liste ARN de l'EFS | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_rds_arn"></a> [rds\_arn](#input\_rds\_arn) | Le nom de ressource Amazon (ARN) de RDS | `string` | n/a | yes |

## Outputs

No outputs.
