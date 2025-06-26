output "db_name" {
  description = "Nom de la base de données créée."
  value       = postgresql_database.app_db.name
}

output "db_user" {
  description = "Nom d'utilisateur de la base de données."
  value       = postgresql_role.user_role.name
}

output "db_admin_user" {
  description = "Nom d'utilisateur administrateur de la base de données."
  value       = postgresql_role.admin_user_role.name
}

output "user_db_secret_arn" {
  description = "ARN du secret utilisateur dans AWS Secrets Manager."
  value       = aws_secretsmanager_secret.user_db_app_secret.arn
}
