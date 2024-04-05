# Identity Provider OICD AWS IAM pour dépôt Github

Crée un Identity Provider OICD ainsi qu'un rôle dans le service IAM d'un compte de travail AWS-SEA. Celui-ci permet à un dépôt Github d'assumer un rôle dans le compte AWS lorsque des Github Actions sont déclenchés.

## Utilisation

Pour installer l'IDP dans un compte de travail:

1. Configurer un profil de connexion AWS CLI pour le compte AWS qui doit être lié ([Voir exemple](../../README.md#utiliser-la-connexion-au-compte-aws-via-un-profil-de-connexion-du-client-aws));
2. Copier l'[exemple](../../examples/aws-sea-iam-identity-provider-for-github/) d'utilisation du module;
2. Définir la *permission policy* à appliquer au rôle IAM. Vous pouvez utiliser une *policy* déjà présente dans le compte ou en [définir une dans votre déploiement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy);
3. Faire une copie du fichier terraform.tfvars.example et renseigner les valeurs:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
    Dans le fichier:
    ```HCL
    aws_profile           = "[Nom du profil du compte AWS (étape 1)]"
    identifier            = "[Nom à donné au IDP]"
    depot_github          = "[Organisation Github]/[Nom du dépôt]"
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
| <a name="input_branche"></a> [branche](#input\_branche) | Nom de la branche du dépôt pouvant déclencher une action dans le compte AWS | `string` | n/a | yes |
| <a name="input_depot_github"></a> [depot\_github](#input\_depot\_github) | Nom complet du dépôt Github (Organisation/depot) | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Nom unique pour identifier les ressources AWS | `string` | n/a | yes |
| <a name="input_permissions_policies"></a> [permissions\_policies](#input\_permissions\_policies) | Liste des noms des politiques de permissions à attacher au rôle du fournisseur | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_identity_provider_arn"></a> [iam\_identity\_provider\_arn](#output\_iam\_identity\_provider\_arn) | ARN du fournisseur d'identité IAM |
