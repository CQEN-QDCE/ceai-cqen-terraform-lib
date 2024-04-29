# Exemples d'utilisation de la librairie

## Modules déployés

* [sea-network](../aws/sea-network/README.md)
* [sea-rds-aurora-mysql](../aws/sea-rds-aurora-mysql/README.md)
* [sea-ecs-cluster](../aws/sea-ecs-cluster/README.md)
* [sea-ecs-fargate-service](../aws/sea-ecs-fargate-service/README.md)
* [sea-cicd-codebuild](../aws/sea-cicd-codebuild/README.md)

## Procédure

1. Créer workspace
   - Aller au répertoire des resources à déployer, par exemple "aws-sea"

    ```bash
    cd aws-sea
    terraform workspace new test
    ```

2. Créer le profil vers le compte de travail AWS .

    Utiliser le cli aws et complétez les informations requises avec:
    ```
    aws sso configure
    ```

    Ou créez ou éditez votre fichier `$HOME/.aws/config` en remplaçant les {valeurs} par celles du compte AWS utilisé, tel que indiqué [ici](../README.md#utiliser-la-connexion-au-compte-aws-via-un-profil-de-connexion-du-client-aws).

3. Renommer le fichier environment/test/terraform.tfvars.example: terraform.tfvars. Y renseigner les variables avec les informations du compte AWS ainsi qu'un identifiant pour votre déploiement.
    ```
    aws_profile           = "{Nom du profile}"
    workload_account_type = "{Type de compte de travail (Sandbox, Dev ou Prod)}"
    identifier            = "{Nom du déploiement}"
    ```

4. Démarrer une session AWS CLI vers le compte de travail. 
    ```bash
    aws sso login --profile [nom_profile]
    ```

5. Lancer la commande d'initialisation 
    ```
    terraform init
    ```

6. Lancer la commande `plan` 
    ```
    terraform plan -var-file=./environments/test/terraform.tfvars
    ```

7. Lancer la commande `apply`, pour déployer les services dans le compte.
    ```
    terraform apply -var-file=./environments/test/terraform.tfvars
    ```

8. Lancer la commande `destroy`, pour supprimer les services déployés.
    ```
    terraform destroy -var-file=./environments/test/terraform.tfvars
    ```