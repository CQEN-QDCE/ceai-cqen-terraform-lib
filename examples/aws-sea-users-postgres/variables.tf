variable "identifier" {
  description = "Unique identifier for the RDS resource."
  type        = string
  default     = "keycloak"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = ""
}

variable "cluster_region" {
  description = "Region to create the cluster."
  type        = string
  default     = "ca-central-1"
}

variable "aws_profile" {
  type        = string
  description = "Optional: If using an SSO connection, specify the SSO profile name in the .aws/config file on the machine executing the deployment."
  default     = null
}

variable "db_master_user" {
  description = "Primary database user name."
  type        = string
}

variable "db_user" {
  description = "Application database user name."
  type        = string
}

variable "db_admin_user" {
  description = "Admin user name for the application."
  type        = string
}

variable "db_host" {
  description = "Database host."
  type        = string
}

variable "db_master_password" {
  description = "Superuser password for the database."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database connection port."
  type        = number
  default     = 5432
}