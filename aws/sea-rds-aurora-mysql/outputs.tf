output "endpoint" {
    value = aws_rds_cluster.aurora_mysql_cluster.endpoint
    description = "Point de terminaison du cluster Aurora MySQL"
}

output "db_name" {
    value = aws_rds_cluster.aurora_mysql_cluster.database_name
    description = "Nom de la base de donnée MySQL"
}

output "db_user_secret" {
    value = "${aws_secretsmanager_secret.rds_secret.arn}:DB_USER::"
    description = "Référence vers le secret contenant le nom d'usager administrateur de la base de donnée MySQL"
}

output "db_password_secret" {
    value = "${aws_secretsmanager_secret.rds_secret.arn}:DB_PASS::"
    description = "Référence vers le secret contenant le mot de passe administrateur de la base de donnée MySQL"
}

output "cluster_rds_arn" {
    value = aws_rds_cluster.aurora_mysql_cluster.arn
    description = "ARN du cluster Aurora MySQL dans RDS"
}

output "cluster_rds_id" {
    value = aws_rds_cluster.aurora_mysql_cluster.id
    description = "Id du cluster Aurora MySQL dans RDS"
}

output "rds_db_pass" {
    value = "${random_password.db_password.result}"
    description = "Le mot de passe administrateur de la base de donnée MySQL"
}

output "rds_db_deploy" {
    value = "${aws_rds_cluster_instance.aurora_mysql_instance}"
    description = "La ressource aws pour voir si l'instance mysql est bien déployée"
}