module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=feature/users-postgres"
}

module "db_users_postgres" {
  source             = "./.terraform/modules/ceai_lib/aws/sea-users-rds-postgres"
  identifier         = format("%s-%s", var.identifier, terraform.workspace)
  db_master_user     = var.db_master_user
  db_user            = var.db_user
  db_admin_user      = var.db_admin_user
  db_app_name        = format("%s-%s", var.identifier, terraform.workspace)
  db_host            = var.db_host
  db_master_password = var.db_master_password
  db_port            = var.db_port
}