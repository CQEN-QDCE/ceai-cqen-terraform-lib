provider "aws" {
  region  = var.cluster_region
  profile = var.aws_profile
  default_tags {
    tags = {
      Project = var.project_name
      System  = format("%s-%s", var.identifier, terraform.workspace)
    }
  }
}