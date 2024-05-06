locals {
  name           = "${var.system}-${var.environment}-tbd"
  container_name = "${var.system}-container"
}

module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=sea-cicd-codebuild"
}

module "ecr" {
  source = "./modules/ecr"

  identifier = local.name
}

module "sea_cicd_codebuild" {
  source = "./.terraform/modules/ceai_lib/aws/sea-cicd-codebuild"

  identifier              = local.name
  app_buildspec_path      = var.app_buildspec_path
  app_ecs_container_name  = local.container_name
  app_ecr_repository_name = module.ecr.ecr_name
  app_name                = var.app_name
  app_path                = var.app_path
  github_repo_url         = var.github_repo_url
  github_repo_branch      = var.github_repo_branch
}