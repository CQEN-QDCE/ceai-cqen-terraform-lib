module "sea_network" {
    source = "../aws/sea-network"
    workload_account_type = "Dev"
}

module "mysql" {
    source = "../aws/sea-rds-aurora-mysql"
    sea_network = module.sea_network.all
    identifier = "test"
    db_name = "test"
    db_user = "test"
    allocated_storage = 20
    max_allocated_storage = 100
    min_capacity = 0.5
    max_capacity = 2
}

module "ecs_cluster" {
    source = "../aws/sea-ecs-cluster"
    identifier = "test"
}