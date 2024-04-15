# Identity Provider OICD AWS IAM pour dépôt Github

Crée un Identity Provider OICD ainsi qu'un rôle dans le service IAM d'un compte de travail AWS-SEA. Celui-ci permet à un dépôt Github d'assumer un rôle dans le compte AWS lorsque des Github Actions sont déclenchés.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.identity_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.idp_github_role_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.iam_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.github_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_branche"></a> [branche](#input\_branche) | Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS (dev/test/prod) | `string` | n/a | yes |
| <a name="input_depots_github"></a> [depots\_github](#input\_depots\_github) | Nom complet des dépôts Github autorisé à assumer le rôle AWS (Organisation/depot) | `list(string)` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_permissions_policies"></a> [permissions\_policies](#input\_permissions\_policies) | Liste des noms des politiques de permissions à attacher au rôle AWS | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_github_action_idp_arn"></a> [iam\_github\_action\_idp\_arn](#output\_iam\_github\_action\_idp\_arn) | ARN du fournisseur d'identité IAM OIDC pour Github Actions |
| <a name="output_iam_github_action_role_arn"></a> [iam\_github\_action\_role\_arn](#output\_iam\_github\_action\_role\_arn) | ARN du role |
