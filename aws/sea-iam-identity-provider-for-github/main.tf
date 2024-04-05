locals {
  name = "${var.identifier}-iam-idp-for-github"
}

resource "aws_iam_openid_connect_provider" "identity_provider" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] #https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/
}

data "aws_iam_policy_document" "github_trust_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type = "Federated"
      identifiers = [
        "${aws_iam_openid_connect_provider.identity_provider.arn}",
      ]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.depot_github}:ref:refs/heads/${var.branche}"]
    }
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  name = "${local.name}-provider-role"
  assume_role_policy = data.aws_iam_policy_document.github_trust_policy.json
}

data "aws_iam_policy" "iam_policies" {
    for_each = toset(var.permissions_policies)
    
    name = each.value
}

resource "aws_iam_role_policy_attachment" "idp_github_role_policy_attach" {
  for_each = data.aws_iam_policy.iam_policies

  role       = aws_iam_role.iam_role.name
  policy_arn = each.value.arn
}
