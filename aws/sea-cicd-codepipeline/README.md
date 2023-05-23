<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.pipeline_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.pipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.pipeline_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_codecommit_repository_default_branch"></a> [aws\_codecommit\_repository\_default\_branch](#input\_aws\_codecommit\_repository\_default\_branch) | Branch du repo AWS CodeCommit de la définition de l'image docker de l'application. | `string` | n/a | yes |
| <a name="input_aws_codecommit_repository_name"></a> [aws\_codecommit\_repository\_name](#input\_aws\_codecommit\_repository\_name) | Nom du repo AWS CodeCommit de la définition de l'image docker de l'application. | `string` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Nom du cluster ECS | `string` | n/a | yes |
| <a name="input_ecs_service_name"></a> [ecs\_service\_name](#input\_ecs\_service\_name) | Nom du service ECS | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->