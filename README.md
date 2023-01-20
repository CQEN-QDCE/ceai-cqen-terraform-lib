<!-- ENTETE -->
[![img](https://img.shields.io/badge/Lifecycle-Experimental-339999)](https://www.quebec.ca/gouv/politiques-orientations/vitrine-numeriqc/accompagnement-des-organismes-publics/demarche-conception-services-numeriques)
[![Licence](https://img.shields.io/badge/License-LiLiQ--P-blue)]([Licence](/LICENSE))

---
![MCN](https://github.com/CQEN-QDCE/.github/blob/main/images/mcn.png)
<!-- FIN ENTETE -->

# Librairie de modules Terraform pour l'infrastructure du CEAI

Librairie de modules Terraform réutilisables pour concevoir des déploiements dans le laboratoire d'expérimentation infonuagique du CEAI.

## Comment utiliser ces modules ?

### Prérequis

* Linux/MacOs/WSL
* Client Terraform
* Client AWS (Pour modules aws)
* jq

### Importer les modules

Importer le module vide `ceai-lib` pour importer le contenu du dépot Git. Vous pourrez par la suite référencer les modules via le chemin d'import Terraform: `./.terraform/{nom_module_import}/` .

Vous pouvez spécifier le tag de version de la librairie via le paramètre `ref`. Sinon vous obtenez la version la plus récente (non recommandé).

```terraform
module "ceai-lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=v1.0"
}
```

```terraform
module "sea_network" {
  source = "./.terraform/modules/ceai-lib/aws/sea-network"

  aws_profile = var.aws_profile
  workload_account_type = var.workload_account_type
}
```

module "sea_network" {
  source = "../aws/sea-network"
  
  aws_profile = var.aws_profile
  workload_account_type = var.workload_account_type
}

### Exemples de déploiements

 * Conteneurs ECS avec Base de données Aurora MySQL dans AWS-SEA


## Bonnes pratiques d'utilisation

Les librairies tiennent compte de l'utilisation de certaines bonnes pratiques dans leur fonctionnement.

### AWS

#### Utiliser la connexion au compte AWS via un profil de connexion du client AWS.

Sur la machine qui exécute le déploiement, modifier le fichier` $HOME/.aws/config` (Créer le s'il n'existe pas).

```
[profile CompteExemple]
sso_start_url = [Url de connexion AWS SSO]
sso_region = ca-central-1
sso_account_id = [Numéro du compte]
sso_role_name = [Nom du role que vous posséder sur ce compte]
region = ca-central-1
output = json
```

Votre déploiement devra connaitre le nom du profil utilisé pour se connecter à AWS. L'utilisation d'une variable est recommandée.

```terraform
variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/config du poste qui exécute le déploiement"
}
```
#### Identifier le type de compte SEA de travail utilisé

Les modules pour les ressources à déployer dans SEA sont presques tous dépendant du module `sea-network`. Celui-ci doit connaitre le nom du OU du compte du travail (Préfix du VPC partagé). L'utilisation d'une variable est recommandée.

```terraform
variable "workload_account_type" {
  type = string
  description = "Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod]"
}
```

```terraform
module "sea_network" {
  source = "../aws/sea-network"
  
  aws_profile = var.aws_profile
  workload_account_type = var.workload_account_type
}
```

#### Prévoir des valeurs pour les tags `system` et `environment` et forcer ceux-ci en déclarent votre *provider*.

Nous recommandons d'utiliser deux variables dans le fichier `variables.tf`
```terraform
variable "system" {
  type = string
  description = "Nom du système déployé."
  default = "Exemple"
}

variable "environment" {
  type = string
  description = "Nom de l'environnement du sytème déployé."
}
```
Si vous utilisez les workspaces vous pouvez utiliser le nom de celui-ci comme valeur par défaut pour la variable `environment`
```terraform
variable "environment" {
  type = string
  description = "Nom de l'environnement du sytème déployé."
  default = terraform.workspace
}
```
Forcer les tags dans provider.tf
```terraform
provider "aws" {
    region = "ca-central-1"
    profile = var.aws_profile

    default_tags {
        tags = {
            system = var.system
            environment = var.environment
        }
    }
}
```

## License

Ce projet est sous la Licence Libre du Québec - Permissive (LiLiQ-P) version 1.1.

Référez-vous au fichier [LICENCE](LICENCE) pour plus de détails.

## Références

https://developer.hashicorp.com/terraform/language
https://registry.terraform.io/providers/hashicorp/aws/latest/docs
