locals {
  name = "${var.identifier}-${var.engine}"
}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

#-------------------------------------------------------------------------------
# ASM Secret Manager
resource "random_password" "db_password" {
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

resource "aws_secretsmanager_secret" "rds_secret" {
  name = "${local.name}-rds-secret-${random_string.secret_name.result}"
}

resource "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id     = aws_secretsmanager_secret.rds_secret.name
  secret_string = <<EOF
  {
  "DB_PASS": "${random_password.db_password.result}",
  "DB_USER": "${var.db_user}"
  }
EOF
  depends_on    = [aws_secretsmanager_secret.rds_secret]
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "${local.name}-rds-subnet-group"
  description = "Groupe subnet pour ${local.name}"
  subnet_ids  = var.sea_network.data_subnets.ids
}

data "aws_iam_policy_document" "monitoring_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "monitoring.rds.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name               = "${local.name}-rds-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.monitoring_role_policy.json
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy_attach" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier                  = "${local.name}-rds-cluster"
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  database_name                       = var.db_name
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  master_username                     = var.db_user
  master_password                     = random_password.db_password.result
  storage_encrypted                   = true
  kms_key_id                          = data.aws_kms_key.rds.arn
  iam_database_authentication_enabled = false
  vpc_security_group_ids              = setunion([var.sea_network.data_security_group.id], var.vpc_db_additional_security_group_ids)
  skip_final_snapshot                 = false
  final_snapshot_identifier           = "${local.name}-snapshot"
  backup_retention_period             = 30
  preferred_backup_window             = "04:00-04:30"
  preferred_maintenance_window        = "sun:05:00-sun:06:00"
  enabled_cloudwatch_logs_exports     = var.engine == "aurora-postgresql" ? ["postgresql", "instance"] : ["audit", "error", "general", "slowquery"]
  deletion_protection                 = var.deletion_protection
  copy_tags_to_snapshot               = true
  depends_on                          = [aws_db_subnet_group.subnet_group, aws_secretsmanager_secret_version.rds_secret]

  serverlessv2_scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }
}

resource "aws_rds_cluster_instance" "rds_cluster_instance_write" {
  count                                 = 1
  identifier                            = "${local.name}-write-${count.index + 1}"
  cluster_identifier                    = aws_rds_cluster.rds_cluster.id
  instance_class                        = "db.serverless"
  engine                                = aws_rds_cluster.rds_cluster.engine
  engine_version                        = aws_rds_cluster.rds_cluster.engine_version
  publicly_accessible                   = false
  db_subnet_group_name                  = aws_db_subnet_group.subnet_group.name
  monitoring_interval                   = 15
  monitoring_role_arn                   = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 186
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn
  auto_minor_version_upgrade            = true

  tags = {
    Name = "${local.name}-write-${count.index + 1}"
  }
}

resource "aws_rds_cluster_instance" "rds_cluster_instance_read" {
  count                                 = 1
  identifier                            = "${local.name}-read-${count.index + 1}"
  cluster_identifier                    = aws_rds_cluster.rds_cluster.id
  instance_class                        = "db.serverless"
  engine                                = aws_rds_cluster.rds_cluster.engine
  engine_version                        = aws_rds_cluster.rds_cluster.engine_version
  publicly_accessible                   = false
  db_subnet_group_name                  = aws_db_subnet_group.subnet_group.name
  monitoring_interval                   = 15
  monitoring_role_arn                   = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 186
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn
  auto_minor_version_upgrade            = true
  tags = {
    Name = "${local.name}-read-${count.index + 1}"
  }
}