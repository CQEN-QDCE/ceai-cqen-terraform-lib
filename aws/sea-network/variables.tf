variable "aws_profile" {
  type        = string
  description = "Optionnel, Si une connexion SSO est utilisée, spécifier le nom du profil SSO dans le fichier .aws/config du poste qui exécute le déploiement"
  nullable    = true
  default     = null
}

variable "workload_account_type" {
  type        = string
  description = "Type de compte de travail ASEA (Prefix du VPC partagé) [Sandbox, Dev, Prod]"
}

variable "internal_ssl_certificate_domain" {
  type        = string
  description = "Domaine du certificat ACM interne à rechercher"
  default     = "*.asea.cqen.org"
}

variable "elb_logging_config_rule_name" {
  type        = string
  description = "Nom de la règle AWS Config utilisée pour récupérer le bucket S3 où déposer les logs d'accès des ELB"
  default     = "ASEA-LZA-ELB_LOGGING_ENABLED"

  validation {
    condition     = length(trimspace(var.elb_logging_config_rule_name)) > 0
    error_message = "Le nom de la règle AWS Config ELB ne peut pas être vide."
  }
}
