variable "identifier" {
  description = "Nom unique pour identifier les ressources AWS"
  type = string
}

variable "aws_profile" {
  type = string
  description = "Nom du profil de connexion SSO dans le fichier .aws/profile du poste qui exécute le déploiement"
}

variable "backup_tag_key" {
    type = string
    description = "The key in a key-value pair"
}

variable "backup_tag_value" {
    type = string
    description = "The value in a key-value pair.s"
}

variable "rds_arn" {
    type = string
    description = "The Amazon Resource Name (ARN) of RDS"
}

variable "rds_name" {
    type = string
    description = "The name of RDS"
}

variable "backup_alarms_email" {
    type = string
    description = "The Delivers messages via SMTP. endpoint is an email address"
}

variable "backup_rules" {
    description = "The rule object that specifies a scheduled task that is used to back up a selection of resources"
}

variable "efs_arn" {
    description = "The list ARN of EFS"
}

variable "create_backup_rds" {
    description = "If the variable is false, we do not create a backup for RDS by setting the count parameter to 0."
}

variable "create_backup_efs" {
    description = "If the variable is false, we do not create a backup for EFS by setting the count parameter to 0."
}