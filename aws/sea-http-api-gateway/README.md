# SEA-API-Gateway-HTTP

Ce module Terraform crée une API Gateway HTTP sur AWS, permettant de déployer des services Web de manière sécurisée.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.api_domain_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.api_acm_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_api_gateway_domain_name.api_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_domain_name) | resource |
| [aws_apigatewayv2_api.api_http_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_api_mapping.api_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_integration.api_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.api_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_apigatewayv2_vpc_link.api_vpc_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_vpc_link) | resource |
| [aws_route53_record.api_cert_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.api_domain_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_api_gateway_integration_alb_listener_arn"></a> [aws\_api\_gateway\_integration\_alb\_listener\_arn](#input\_aws\_api\_gateway\_integration\_alb\_listener\_arn) | L'ARN du listener du load balancer de l'application | `string` | n/a | yes |
| <a name="input_aws_api_gateway_security_group_ids"></a> [aws\_api\_gateway\_security\_group\_ids](#input\_aws\_api\_gateway\_security\_group\_ids) | Liste d'IDs des groups de sécurité du VPC qui seront associés. | `list(string)` | n/a | yes |
| <a name="input_aws_api_gateway_subnet_ids"></a> [aws\_api\_gateway\_subnet\_ids](#input\_aws\_api\_gateway\_subnet\_ids) | La liste des IDs des subnets web du VPC. | `list(string)` | n/a | yes |
| <a name="input_aws_api_route53_zone_id"></a> [aws\_api\_route53\_zone\_id](#input\_aws\_api\_route53\_zone\_id) | ID de la zone hebergé de la Route53. | `string` | `null` | no |
| <a name="input_aws_cert_domain_name"></a> [aws\_cert\_domain\_name](#input\_aws\_cert\_domain\_name) | Nom du domain du certificat. | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_use_route53"></a> [use\_route53](#input\_use\_route53) | n/a | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | L'URL d'accès de l'API Gateway |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | L'ID de l'API Gateway |
| <a name="output_stage_id"></a> [stage\_id](#output\_stage\_id) | L'ID du stage de l'API Gateway |
| <a name="output_vpc_link_id"></a> [vpc\_link\_id](#output\_vpc\_link\_id) | L'ID du VPC Link |
