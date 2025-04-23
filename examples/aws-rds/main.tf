locals {
  name           = "${var.system}-${var.environment}"
}

module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=feature/sea-rds"
  #source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=dev"
  #source = "../.."  
}

module "sea_network" {
  source = "./.terraform/modules/ceai_lib/aws/sea-network"
  #source = "../../aws/sea-network"

  aws_profile           = var.aws_profile
  workload_account_type = var.workload_account_type
}

/**
Pour les tests, on peut décommenter au besoin le module de base de données qu'on veut tester.
Par défaut, on utilise Aurora PostgreSQL.
**/

/*
module "aurora-mysql" {
  source = "./.terraform/modules/ceai_lib/aws/sea-rds"
  #source = "../../aws/sea-rds-aurora-mysql"

  sea_network  = module.sea_network
  engine      = "aurora-mysql"
  engine_mode = "provisioned" # Serverless v2 uses the provisioned engine_mode.
  engine_version = "8.0.mysql_aurora.3.04.0"
  identifier   = local.name
  db_name      = var.system
  db_user      = var.system
  min_capacity = 0.5
  max_capacity = 2
}*/

module "aurora-postgresql" {
  source = "./.terraform/modules/ceai_lib/aws/sea-rds"
  #source = "../../aws/sea-rds-aurora-mysql"

  sea_network  = module.sea_network
  engine      = "aurora-postgresql"
  engine_mode = "provisioned" # Serverless v2 uses the provisioned engine_mode.
  engine_version = "13.6"
  identifier   = local.name
  db_name      = var.system
  db_user      = var.system
  min_capacity = 0.5
  max_capacity = 2
}

/**
TODO! ajouter le test pour faire l'appel au module sea-rds-aurora-mysql. Après les ajustements dans ce module, il devrait rester fonctionnel.
L'appel au module ancien sea-rds-aurora-mysql (à disparaître), devrait être supporté.
**/