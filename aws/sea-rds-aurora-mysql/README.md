# SEA-ECS-Cluster

Crée un cluster RDS Aurora hébergeant une base de donnée compatible MySQL.

## Ressources créées

* aws_secretsmanager_secret
* aws_secretsmanager_secret_version
* aws_db_subnet_group
* aws_iam_role
* aws_iam_role_policy_attachment
* aws_rds_cluster
* aws_rds_cluster_instance

## Variables

| Nom | Description |
| --- | ----------- |
| identifier | Nom unique pour identifier les ressources AWS |
| sea_network | Données du module sea-network |
| db_name | Nom de la base de données à créer |
| db_user | Nom d'utilisateur de l'usager ayant droit sur la base de données |
| min_capacity | Capacité minimale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM) |
| max_capacity | Capacité maximale provisionnée en ACU (Aurora Capacity Unit, 0,5ACU = 1GB RAM) |
| allocated_storage | Quantité de stockage réservé à la création |
| max_allocated_storage | Quantité de stockage maximum pouvant être réservé en cas de mise à l'échelle du stockage. |

## Data sources 

| Nom | Description |
| --- | ----------- |
| endpoint | Point de terminaison du cluster Aurora MySQL |
| db_name | Nom de la base de donnée MySQL |
| db_user_secret | Référence vers le secret contenant le nom d'usager administrateur de la base de donnée MySQL |
| db_password_secret | Référence vers le secret contenant le mot de passe administrateur de la base de donnée MySQL |
| cluster_rds_arn | ARN du cluster Aurora MySQL dans RDS |
| cluster_rds_id | Id du cluster Aurora MySQL dans RDS |
