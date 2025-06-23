locals {
  name                    = "${var.identifier}-${var.engine}"
  all_privileges_database = ["CREATE", "USAGE"]
  all_privileges_table    = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER"]
}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

#-------------------------------------------------------------------------------
# ASM Secret Manager
resource "random_password" "admin_db_app_password" {
  length           = 20
  special          = true
  min_special      = 1
  override_special = "!?"
}

resource "random_password" "user_db_app_password" {
  length           = 20
  special          = true
  min_special      = 1
  override_special = "!?"
}

resource "random_string" "secret_name" {
  length  = 16
  special = false
  upper   = false
}

resource "aws_secretsmanager_secret" "user_db_app_secret" {
  name = "${local.name}-rds-users-secret-${random_string.secret_name.result}"
}

resource "aws_secretsmanager_secret_version" "user_db_app_secret" {
  secret_id     = aws_secretsmanager_secret.user_db_app_secret.name
  secret_string = <<EOF
  {
  "DB_ADMIN_PASS": "${random_password.admin_db_app_password.result}",
  "DB_ADMIN": "${var.db_user}",
  "DB_PASS": "${random_password.user_db_app_password.result}",
  "DB_USER": "${var.db_user}"
  }
EOF
  depends_on    = [aws_secretsmanager_secret.user_db_app_secret]
}

provider "postgresql" {
  alias           = "admindb"
  host            = var.db_host
  port            = var.db_port
  username        = var.db_master_user
  password        = var.db_master_password
  scheme          = "awspostgres"
  connect_timeout = 20
  sslmode         = "require"
  superuser       = false
}

resource "postgresql_database" "app_db" {
  provider          = postgresql.admindb
  name              = var.db_app_name
  connection_limit  = -1 // -1 means no limit
  allow_connections = true
}

resource "postgresql_role" "admin_user_role" {
  provider = postgresql.admindb
  name            = var.db_admin_user
  login           = true
  create_database = true
  create_role     = true
  password        = random_password.admin_db_app_password.result
}

resource "postgresql_role" "user_role" {
  provider = "postgresql.admindb"
  name     = var.db_user
  login    = true
  password = random_password.user_db_app_password.result
}

resource "postgresql_grant" "db_app_admin" {
  provider    = postgresql.admindb
  database    = postgresql_database.app_db.name
  role        = postgresql_role.user_role.name
  schema      = "public"
  object_type = "schema"
  privileges  = local.all_privileges_database
}


resource "postgresql_grant" "db_app_user" {
  provider    = postgresql.admindb
  database    = postgresql_database.app_db.name
  role        = postgresql_role.user_role.name
  schema      = "public"
  object_type = "table"
  privileges  = local.all_privileges_table
}