# SEA-Codebuild
Crée un projet codebuild qui va exécuter les tâches specifiées dans le fichier buildspec.yaml dans le repo GitHub de l'application.
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
| [aws_codebuild_project.codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.ci_cd_webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_codecommit_repository.img_definition_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_iam_policy.codebuild_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.codebuild_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_secretsmanager_secret.codebuild_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.codebuild_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_buildspec_path"></a> [app\_buildspec\_path](#input\_app\_buildspec\_path) | Path du fichier buildspec de l'application dans le repo GitHub. | `string` | n/a | yes |
| <a name="input_app_ecr_repository_name"></a> [app\_ecr\_repository\_name](#input\_app\_ecr\_repository\_name) | Nom du repo AWS ECR de l'image docker de l'application. | `string` | n/a | yes |
| <a name="input_app_ecs_container_name"></a> [app\_ecs\_container\_name](#input\_app\_ecs\_container\_name) | Nom du container AWS ECS de l'application. | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Nom de l'application. | `string` | n/a | yes |
| <a name="input_app_path"></a> [app\_path](#input\_app\_path) | Path de l'application dans le repo GitHub. | `string` | n/a | yes |
| <a name="input_github_repo_branch"></a> [github\_repo\_branch](#input\_github\_repo\_branch) | Branch du repo GitHub de l'application. | `string` | n/a | yes |
| <a name="input_github_repo_url"></a> [github\_repo\_url](#input\_github\_repo\_url) | URL du repo GitHub de l'application. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_codecommit_repository_default_branch"></a> [aws\_codecommit\_repository\_default\_branch](#output\_aws\_codecommit\_repository\_default\_branch) | Branch du repo AWS CodeCommit de la définition de l'image docker de l'application. |
| <a name="output_aws_codecommit_repository_name"></a> [aws\_codecommit\_repository\_name](#output\_aws\_codecommit\_repository\_name) | Nom du repo AWS CodeCommit de la définition de l'image docker de l'application. |
<!-- END_TF_DOCS -->