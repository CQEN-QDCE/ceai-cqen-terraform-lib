output "shared_vpc" {
  value       = data.aws_vpc.shared_vpc
  description = "VPC partagé du compte de travail"
}

output "web_subnets" {
  value       = data.aws_subnets.web_subnets
  description = "Subnet partagé Web"
}

output "app_subnets" {
  value       = data.aws_subnets.app_subnets
  description = "Subnet partagé App"
}

output "data_subnets" {
  value       = data.aws_subnets.data_subnets
  description = "Subnet partagé Data"
}

output "web_security_group" {
  value       = data.aws_security_group.web_security_group
  description = "Groupe de sécurité partagé Web"
}

output "app_security_group" {
  value       = data.aws_security_group.app_security_group
  description = "Groupe de sécurité partagé App"
}

output "data_security_group" {
  value       = data.aws_security_group.data_security_group
  description = "Groupe de sécurité partagé Data"
}

output "default_internal_ssl_certificate" {
  value       = var.workload_account_type == "Sandbox" ? null : data.aws_acm_certificate.default_internal_ssl_certificate
  description = "Certificat SSL interne par défaut du compte"
}

output "elb_access_log_bucket_name" {
  value       = var.workload_account_type == "Sandbox" ? null : data.external.config_rule_elb_logging_enabled[0].result.s3BucketNames
  description = "Nom du bucket S3 où déposer les logs d'accès des ELB pour satisfaire la règle AWS Config :ELB_LOGGING_ENABLED"
}

/*
output "sea_access_log_bucket_name" {
  value   = data.external.config_rule_elb_logging_enabled.result.s3BucketNames
  description = "Nom du bucket S3 où déposer les logs d'accès des services requierant le stockage de logs d'accès centralisé"
}
*/

output "s3_kms_encryption_key_arn" {
  value       = var.workload_account_type == "Sandbox" ? null : data.external.config_rule_s3_bucket_encryption_enabled[0].result.arn
  description = "Arn de la clé KMS pour encrypter un bucket S3 pour satisfaire la règle AWS Config :S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
}

output "web_subnet_a" {
  value       = data.aws_subnet.web_subnet_a
  description = "Subnet partagé Web zone a"
}

output "app_subnet_b" {
  value       = data.aws_subnet.app_subnet_b
  description = "Subnet partagé App zone b"
}

output "data_subnet_a" {
  value       = data.aws_subnet.data_subnet_a
  description = "Subnet partagé Data zone a"
}

output "web_subnet_b" {
  value       = data.aws_subnet.web_subnet_b
  description = "Subnet partagé Web zone b"
}

output "app_subnet_a" {
  value       = data.aws_subnet.app_subnet_a
  description = "Subnet partagé App zone a"
}

output "data_subnet_b" {
  value       = data.aws_subnet.data_subnet_b
  description = "Subnet partagé Data zone b"
}