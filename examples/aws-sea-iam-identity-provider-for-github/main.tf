locals {
  name = "${var.system}-${var.environment}"
}

module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=3.0"
}

module "sea_iam_identity_provider_for_github" {
  source = "./.terraform/modules/ceai_lib/aws/sea-iam-identity-provider-for-github"

  identifier = local.name
  depot_github = var.depot_github
  branche = var.branche
  permissions_policies = var.permissions_policies
}
