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
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_arn"></a> [ecr\_arn](#output\_ecr\_arn) | ARN du repo. |
| <a name="output_ecr_id"></a> [ecr\_id](#output\_ecr\_id) | ID du repo. |
| <a name="output_ecr_image_uri"></a> [ecr\_image\_uri](#output\_ecr\_image\_uri) | URI du repo. |
| <a name="output_ecr_name"></a> [ecr\_name](#output\_ecr\_name) | Nom du repo. |
<!-- END_TF_DOCS -->