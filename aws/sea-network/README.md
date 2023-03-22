# SEA-Network

Récupère les ressources réseautique du compte de travail spécifié et les exporte dans des *data sources*.

## Ressources créées

Aucune

## Variables

| Nom | Description |
| --- | ----------- |
| aws_profile | Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement |
| workload_account_type | Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod] |

## Data sources 

| Nom | Description |
| --- | ----------- |
| shared_vpc | VPC partagé du compte de travail |
| web_subnets | Subnet partagé Web |
| app_subnets | Subnet partagé App |
| data_subnets | Subnet partagé Data |
| web_security_group | Groupe de sécurité partagé Web |
| app_security_group | Groupe de sécurité partagé App |
| data_security_group | Groupe de sécurité partagé Data |
| elb_access_log_bucket_name | Nom du bucket S3 oiù déposer les logs d'accès des ELB pour satisfaire la règle AWS Config :ELB_LOGGING_ENABLED |
| all | Objet contenant toutes les data sources concernant la réseautique partagée des comptes de travail SEA |