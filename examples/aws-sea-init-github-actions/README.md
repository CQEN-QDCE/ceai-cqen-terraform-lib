# IDP et bucket de déploiement pour Github Actions et Terraform

## Utilisation

Pour installer l'IDP et le bucket dans un compte de travail:

1. Configurer un profil de connexion AWS CLI pour le compte AWS qui doit être lié ([Voir exemple](../../README.md#utiliser-la-connexion-au-compte-aws-via-un-profil-de-connexion-du-client-aws));
2. Copier l'[exemple](../../examples/aws-sea-iam-identity-provider-for-github/) d'utilisation du module;
2. Définir la *permission policy* à appliquer au rôle IAM. Vous pouvez utiliser une *policy* déjà présente dans le compte ou en [définir une dans votre déploiement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy);
3. Faire une copie du fichier terraform.tfvars.example et renseigner les valeurs:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
    Dans le fichier:
    ```HCL
    #aws_profile          = ""
    workload_account_type = "Dev" 
    system                = "test"
    environment           = "test"
    depots_github          = [""]
    branche               = ""
    permissions_policies  = ""

    aws_profile           = "[Nom du profil du compte AWS (étape 1)]"
    workload_account_type = "[Type de compte de travail (Dev ou Prod)]" 
    system                = "[Nom du système déployé dans le compte]"
    environment           = "[Nom du niveau d'environnement du système]"
    depots_github          = ["[Organisation Github]/[Nom du dépôt]"]
    branche               = "[Branche pouvant déployer dans le compte]"
    permissions_policies  = ["[Nom des permissions polices à appliquer au rôle IAM]"]
    ```
4. Déployer l'IDP dans le compte:
    ```bash
    aws sso login --profile [Nom du profile AWS CLI]

    terraform init

    terraform plan -var-file=terraform.tfvars

    terraform apply -var-file=terraform.tfvars
    ```


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ceai_lib"></a> [ceai\_lib](#module\_ceai\_lib) | ../.. | n/a |
| <a name="module_sea_iam_identity_provider_for_github"></a> [sea\_iam\_identity\_provider\_for\_github](#module\_sea\_iam\_identity\_provider\_for\_github) | ../../aws/sea-iam-identity-provider-for-github | n/a |
| <a name="module_sea_network"></a> [sea\_network](#module\_sea\_network) | ../../aws/sea-network | n/a |
| <a name="module_sea_s3_bucket"></a> [sea\_s3\_bucket](#module\_sea\_s3\_bucket) | ../../aws/sea-s3-bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.idp_only_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement | `string` | `null` | no |
| <a name="input_branche"></a> [branche](#input\_branche) | Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS | `string` | n/a | yes |
| <a name="input_depots_github"></a> [depots\_github](#input\_depots\_github) | Liste de nom complet des dépôts Github (Organisation/depot) pouvant utiliser le IDP | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement du système déployé. | `string` | n/a | yes |
| <a name="input_permissions_policies"></a> [permissions\_policies](#input\_permissions\_policies) | Liste des noms des politiques de permissions à attacher au rôle du fournisseur | `list(string)` | n/a | yes |
| <a name="input_system"></a> [system](#input\_system) | Nom du système déployé. | `string` | `"Exemple"` | no |
| <a name="input_workload_account_type"></a> [workload\_account\_type](#input\_workload\_account\_type) | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] | `string` | n/a | yes |

## Outputs

No outputs.
