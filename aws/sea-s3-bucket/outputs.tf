output "bucket_arn" {
  value       = aws_s3_bucket.sea_bucket.arn
  description = "Arn du bucket S3"
}

output "bucket_name" {
  value       = aws_s3_bucket.sea_bucket.bucket
  description = "Nom (id) du bucket S3"
}

output "bucket_policy_id" {
  value       = aws_s3_bucket_policy.s3_bucket_policy.id
  description = "Identifiant de la policy du bucket S3"
}