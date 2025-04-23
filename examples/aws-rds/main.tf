locals {
  name           = "${var.system}-${var.environment}"
  container_name = "${var.system}-container"
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

module "mysql" {
  source = "./.terraform/modules/ceai_lib/aws/sea-rds"
  #source = "../../aws/sea-rds-aurora-mysql"

  sea_network  = module.sea_network
  engine      = "mysql"
  engine_mode = "serverless"
  identifier   = local.name
  db_name      = var.system
  db_user      = var.system
  min_capacity = 0.5
  max_capacity = 2
}

#TODO! Test it! 