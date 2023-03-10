locals {
  name = "${var.identifier}"
}

data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

#-------------------------------------------------------------------------------
# ASM Secret Manager
resource "random_password" "db_password"{
  length           = 20
  special          = true
  min_special       = 1
  override_special  = "!?"
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name = "${local.name}-secret"
}

resource "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = "${local.name}-rds-secret"
  secret_string = <<EOF
  {
  "DB_PASS": "${random_password.db_password.result}",
  "DB_USER": "${var.db_user}"
  }
EOF
 depends_on = [ aws_secretsmanager_secret.rds_secret ]
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "${local.name}-rds-subnet-group"
  description = "${local.name}"
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
  name = "${local.name}-rds-monitoring-role"
  assume_role_policy = data.aws_iam_policy_document.monitoring_role_policy.json
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy_attach" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_rds_cluster" "aurora_mysql_cluster" {
  cluster_identifier                  = "${local.name}"
  engine                              = "aurora-mysql"
  engine_mode                         = "provisioned"
  engine_version                      = "8"
  database_name                       = var.db_name
  db_subnet_group_name                = aws_db_subnet_group.subnet_group.name
  master_username                     = var.db_user
  master_password                     = "${random_password.db_password.result}"
  storage_type                        = "io1"
  allocated_storage                   = var.allocated_storage
  storage_encrypted                   = true
  kms_key_id                          = data.aws_kms_key.rds.arn
  iam_database_authentication_enabled = false
  vpc_security_group_ids              = [var.sea_network.data_security_group.id]
  skip_final_snapshot                 = false
  final_snapshot_identifier           = "${local.name}-snapshot"
  preferred_maintenance_window        = "sun:05:00-sun:06:00"
  depends_on                          = [ aws_db_subnet_group.subnet_group, aws_secretsmanager_secret_version.rds_secret ]

  serverlessv2_scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }
}

resource "aws_rds_cluster_instance" "aurora_mysql_instance" {
  identifier_prefix                     = "${local.name}-instance-"
  cluster_identifier                    = aws_rds_cluster.aurora_mysql_cluster.id
  instance_class                        = "db.serverless"
  engine                                = aws_rds_cluster.aurora_mysql_cluster.engine
  engine_version                        = aws_rds_cluster.aurora_mysql_cluster.engine_version
  publicly_accessible                   = false
  db_subnet_group_name                  = aws_db_subnet_group.subnet_group.name
  monitoring_interval                   = 15
  monitoring_role_arn                   = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 186
  performance_insights_kms_key_id       = data.aws_kms_key.rds.arn
}
