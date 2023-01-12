output "endpoint" {
    value = "${aws_rds_cluster.aurora_mysql_cluster.endpoint}"
    description = "Point de terminaison du cluster Aurora MySQL"
}

output "secretsmanager_arn" {
    value = "${aws_secretsmanager_secret.rds_secret.arn}"
    description = "ARN du secret contenant le mot de passe de la base de donnée"
}

output "cluster_rds_arn" {
    value = aws_rds_cluster.aurora_mysql_cluster.arn
    description = "ARN du cluster Aurora MySQL dans RDS"
}

output "cluster_rds_name" {
    value = aws_rds_cluster.aurora_mysql_cluster.name
    description = "Nom du cluster Aurora MySQL dans RDS"
}