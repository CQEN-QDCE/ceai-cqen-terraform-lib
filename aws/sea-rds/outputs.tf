output "endpoint" {
  value       = aws_rds_cluster.rds_cluster.endpoint
  description = "Point de terminaison du cluster dans RDS"
}

output "db_name" {
  value       = aws_rds_cluster.rds_cluster.database_name
  description = "Nom de la base de donnée créée"
}

output "db_user_secret" {
  value       = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["DB_USER"]
  description = "Référence vers le secret contenant le nom d'usager administrateur de la base de donnée "
}

output "db_password_secret" {
  value       = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)["DB_PASS"]
  description = "Référence vers le secret contenant le mot de passe administrateur de la base de donnée "
}

output "cluster_rds_arn" {
  value       = aws_rds_cluster.rds_cluster.arn
  description = "ARN du cluster  dans RDS"
}

output "cluster_rds_id" {
  value       = aws_rds_cluster.rds_cluster.id
  description = "Id du cluster  dans RDS"
}

output "rds_db_pass" {
  value       = random_password.db_password.result
  description = "Le mot de passe administrateur de la base de donnée "
}

output "rds_cluster_instance" {
  value       = aws_rds_cluster_instance.rds_cluster_instance_read
  description = "La ressource aws pour voir si l'instance  est bien déployée"
}