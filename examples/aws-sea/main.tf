locals {
  name = "${var.system}-${var.environment}"
  container_name = "${var.system}-container"
}

module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=dev"
}

module "sea_network" {
  source = "./.terraform/modules/ceai_lib/aws/sea-network"
  
  aws_profile = var.aws_profile
  workload_account_type = var.workload_account_type
}

module "mysql" {
  source = "./.terraform/modules/ceai_lib/aws/sea-rds-aurora-mysql"
  
  sea_network           = module.sea_network
  identifier            = local.name
  db_name               = var.system
  db_user               = var.system
  allocated_storage     = 20
  max_allocated_storage = 100
  min_capacity          = 0.5
  max_capacity          = 2
}

module "ecs_cluster" {
  source = "./.terraform/modules/ceai_lib/aws/sea-ecs-cluster"
  
  identifier = local.name
}

data "template_file" "container_test" {
  template = file("${path.module}/tasks/task.json.tftpl")
  vars = {
    container_name       = local.container_name
    image                = "rhel-minimal:latest"
    awslogs_group        = "/ecs/test-task"
    container_port       = 8080
    healthckeck_path     = "/healthcheck"
    environment          = terraform.workspace
    mysql_user_secret    = module.mysql.db_user_secret
    mysql_user_password  = module.mysql.db_password_secret
    test_volume_name     = "test"
    test_volume_path     = "/opt/test"
  }
}

module "ecs_service" {
  source = "./.terraform/modules/ceai_lib/aws/sea-ecs-fargate-service"
  
  sea_network = module.sea_network
  identifier  = local.name
  task_definition = data.template_file.container_test.rendered
  task_container_name = local.container_name
  task_port = 8080
  task_protocol = "HTTP"
  task_vcpu = 512
  task_memory = 1

  task_minimum_count = 1
  task_maximum_count = 1
  ecs_cluster = module.ecs_cluster

  task_healthcheck_path = "/healthcheck"
  task_healthcheck_protocol = "HTTP"
  volume_efs = {
    "exemple" = {
      name = "${local.name}-exemple"
      mount_path = "/opt/exemple/"
    }
  }
}