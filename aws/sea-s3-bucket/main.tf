locals {
  name = "${var.identifier}-s3-bucket"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sea_bucket" {
  bucket = var.name
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.sea_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.sea_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sea_network.s3_kms_encryption_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

data "aws_iam_policy_document" "s3_secure_transport_policy" {
  statement {
    sid = "AllowSSLRequestsOnly"
    
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:*"
    ]

    effect = "Deny"

    resources = [
      aws_s3_bucket.sea_bucket.arn,
      "${aws_s3_bucket.sea_bucket.arn}/*",
    ]

    condition {
      test = "Bool"
      variable = "aws:SecureTransport"
      values = ["false"]
    }
  }
}

data "aws_iam_policy_document" "s3_combined_policy" {
  source_policy_documents = [
    var.bucket_policy,
    data.aws_iam_policy_document.s3_secure_transport_policy.json
  ]
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.sea_bucket.id
  policy = data.aws_iam_policy_document.s3_combined_policy.json
}

/*
resource "aws_s3_bucket_logging" "s3_bucket_access_logs" {
  bucket = aws_s3_bucket.sea_bucket.id

  target_bucket = var.sea_network.sea_access_log_bucket_name
  target_prefix  = "${data.aws_caller_identity.current.account_id}/S3-access-log-${local.name}/"
}
*/