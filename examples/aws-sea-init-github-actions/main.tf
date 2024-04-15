locals {
  name = "${var.system}-${var.environment}"
}

module "ceai_lib" {
  source = "github.com/CQEN-QDCE/ceai-cqen-terraform-lib?ref=2.0"
}

module "sea_network" {
  source = "./.terraform/modules/ceai_lib/aws/sea-network"
  
  aws_profile = var.aws_profile
  workload_account_type = var.workload_account_type
}

module "sea_iam_identity_provider_for_github" {
  source = "./.terraform/modules/ceai_lib/aws/sea-iam-identity-provider-for-github"

  identifier = local.name
  depots_github = var.depots_github
  branche = var.branche
  permissions_policies = var.permissions_policies
}

data "aws_iam_policy_document" "idp_only_policy" {
  statement {
    sid = "GithubActionAccessGrant"
    
    principals {
      type        = "Federated"
      identifiers = ["${module.sea_iam_identity_provider_for_github.iam_github_action_idp_arn}"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
        "${module.sea_s3_bucket.bucket_arn}",
        "${module.sea_s3_bucket.bucket_arn}/*",
    ]
  }
}

module "sea_s3_bucket" {
  source = "./.terraform/modules/ceai_lib/aws/sea-s3-bucket"

  sea_network = module.sea_network
  identifier = local.name
  name = "${local.name}-github-action-ressources"
  bucket_policy = data.aws_iam_policy_document.idp_only_policy.json
}
