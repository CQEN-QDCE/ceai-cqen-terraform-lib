output "endpoint" {
    value = "${aws_rds_cluster.aurora_mysql_cluster.endpoint}"
    description = "Point de terminaison du cluster Aurora MySQL"
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