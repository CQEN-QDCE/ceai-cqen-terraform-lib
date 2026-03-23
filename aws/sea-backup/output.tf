output "plan_id" {
  value       = aws_backup_plan.backup_plan.id
  description = "ID du plan de sauvegarde AWS Backup."
}

output "vault_arn" {
  value       = aws_backup_vault.backup_vault.arn
  description = "ARN de la vault de sauvegarde AWS Backup."
}