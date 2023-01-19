module "sea_network" {
  source = "../aws/sea-network"
  
  aws_profile = var.aws_profile
  workload_account_type = "Dev"
}

module "mysql" {
  source = "../aws/sea-rds-aurora-mysql"
  
  sea_network           = module.sea_network.all
  identifier            = "test"
  db_name               = "test"
  db_user               = "test"
  allocated_storage     = 20
  max_allocated_storage = 100
  min_capacity          = 0.5
  max_capacity          = 2
}

module "ecs_cluster" {
  source = "../aws/sea-ecs-cluster"
  
  identifier = "test"
}

data "template_file" "container_test" {
  template = file("${path.module}/tasks/test_task.json")
  vars = {
    container_name       = "test-container"
    image                = "rhel-minimal:latest"
    awslogs_group        = "/ecs/test-task"
    container_port       = 8080
    healthckeck_path     = "/healthcheck"
    environment          = terraform.workspace
    mysql_user_secret    = module.mysql.db_user_secret
    mysql_user_password  = module.mysql.db_password_secret
  }
}

module "ecs_service" {
  source = "../aws/sea-ecs-fargate-service"
  
  sea_network = module.sea_network.all
  identifier  = "test"
  ecs_cluster_id = module.ecs_cluster.cluster_id
  task_definition = data.template_file.container_test.rendered
  task_port = 8080
  task_protocol = "HTTP"
  task_vcpu = 512
  task_memory = 1
  task_count = 1
  task_healthcheck_path = "/healthcheck"
  task_healthcheck_protocol = "HTTP"
  volume_efs = {
    "test" = {
      name = "test"
      mount_path = "/opt/test/"
    }
  }
}