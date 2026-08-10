output "plan_id" {
  value       = aws_backup_plan.backup_plan.id
  description = "ID du plan de sauvegarde AWS Backup."
}

output "vault_arn" {
  value       = aws_backup_vault.backup_vault.arn
  description = "ARN de la vault de sauvegarde AWS Backup."
}

output "iam_role_backup_arn" {
  value       = aws_iam_role.aws_backup_service_role.arn
  description = "ARN du rôle IAM pour le service AWS Backup."
}