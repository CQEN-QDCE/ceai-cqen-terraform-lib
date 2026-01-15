output "iam_github_action_idp_arn" {
  value       = aws_iam_openid_connect_provider.identity_provider.arn
  description = "ARN du fournisseur d'identité IAM OIDC pour Github Actions"
}

output "iam_github_action_role_arn" {
  value       = var.create_role ? aws_iam_role.iam_role[0].arn : null
  description = "ARN du role IAM associé au fournisseur d'identité pour GitHub Actions"
}
