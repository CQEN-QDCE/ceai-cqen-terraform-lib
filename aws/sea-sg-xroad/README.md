# LZA-SG-XROAD

Ce module Terraform a pour objectif de provisionner l’ensemble des groupes de sécurité (Security Groups) nécessaires à l’infrastructure X-Road dans AWS.
Il gère les règles réseau pour les composants internes (EC2, ALB, NLB, management, administration) tout en permettant d’activer ou désactiver dynamiquement les ressources selon le rôle du déploiement (services centraux, sous-systèmes, etc.).

## Fonctionnalités principales

Création des Security Groups pour :

* les NLB internes.
* l’ALB d'administration
* les instances EC2 de X-Road pour le central serveur
* la communication interne entre composants X-Road
* Le EKS de serveur de securité

* Activation conditionnelle des ressources via var.is_central_services
* Exposition propre des identifiants des SG via des outputs conditionnels
* Compatible avec une architecture réseau partagée (shared VPC)

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | github.com/CQEN-QDCE/ceai-cqen-terraform-lib | v4.2 |
| <a name="module_sea_network"></a> [sea\_network](#module\_sea\_network) | ./.terraform/modules/ceai_lib/aws/sea-network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.alb_cs_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.alb_ss_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ec2_cs_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_ss_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nlb_cs_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nlb_internal_mgmt_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nlb_ss_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.alb_cs_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.alb_ss_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.ec2_to_postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.eks_outbound_cs_management_services](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.eks_outbound_ss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.eks_outbound_ss_postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.nlb_cs_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.nlb_internal_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.nlb_ss_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.alb_cs_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.alb_ss_internal_admin_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ec2_from_internal_admin_cs_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ec2_from_internal_cs_nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ec2_from_internal_mgmt_nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.eks_inbound_ss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.nlb_cs_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.nlb_internal_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.nlb_ss_internal_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_assume_role_workload"></a> [aws\_assume\_role\_workload](#input\_aws\_assume\_role\_workload) | Rôle à assumer pour le compte de travail | `string` | `null` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Porifle AWS à utiliser pour la création des ressources | `string` | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Région AWS où les ressources seront créées | `string` | `"ca-central-1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement du système déployé. | `string` | n/a | yes |
| <a name="input_is_central_services"></a> [is\_central\_services](#input\_is\_central\_services) | Indique si le déploiement concerne les services centraux. | `bool` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Nom du système déployé. | `string` | n/a | yes |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_cs_internal_admin_sg_id"></a> [alb\_cs\_internal\_admin\_sg\_id](#output\_alb\_cs\_internal\_admin\_sg\_id) | CS ALB Admin SG |
| <a name="output_alb_ss_internal_admin_sg_id"></a> [alb\_ss\_internal\_admin\_sg\_id](#output\_alb\_ss\_internal\_admin\_sg\_id) | SS ALB Admin SG |
| <a name="output_ec2_cs_internal_sg_id"></a> [ec2\_cs\_internal\_sg\_id](#output\_ec2\_cs\_internal\_sg\_id) | CS EKS internal SG |
| <a name="output_eks_ss_internal_sg_id"></a> [eks\_ss\_internal\_sg\_id](#output\_eks\_ss\_internal\_sg\_id) | SS EKS internal SG |
| <a name="output_nlb_cs_internal_sg_id"></a> [nlb\_cs\_internal\_sg\_id](#output\_nlb\_cs\_internal\_sg\_id) | CS NLB SG |
| <a name="output_nlb_internal_mgmt_sg_id"></a> [nlb\_internal\_mgmt\_sg\_id](#output\_nlb\_internal\_mgmt\_sg\_id) | mgmt NLB SG |
| <a name="output_nlb_ss_internal_sg_id"></a> [nlb\_ss\_internal\_sg\_id](#output\_nlb\_ss\_internal\_sg\_id) | SS NLB SG |
