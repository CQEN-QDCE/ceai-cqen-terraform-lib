output "iam_identity_provider_arn" {
  value = aws_iam_openid_connect_provider.identity_provider.arn
  description = "ARN du fournisseur d'identité IAM"
}
