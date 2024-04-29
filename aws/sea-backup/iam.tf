data "aws_caller_identity" "current_account" {}

data "aws_iam_policy_document" "aws_backup_service_assume_role_policy" {
  statement {
    sid     = "AssumeServiceRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

/* Needed to allow the backup service to restore from a snapshot to an EC2 instance
 See https://stackoverflow.com/questions/61802628/aws-backup-missing-permission-iampassrole */
data "aws_iam_policy_document" "pass_role_policy_doc" {
  statement {
    sid       = "PassRole"
    actions   = ["iam:PassRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_account.account_id}:role/*"]
  }
}

/* Roles for taking AWS Backups */
resource "aws_iam_role" "aws_backup_service_role" {
  name               = "${local.name}-AWSBackupServiceRole"
  description        = "Allows the AWS Backup Service to take scheduled backups"
  assume_role_policy = data.aws_iam_policy_document.aws_backup_service_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "backup_service_aws_backup_role_policy" {
  role   = aws_iam_role.aws_backup_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore_service_aws_backup_role_policy" {
  role   = aws_iam_role.aws_backup_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_iam_role_policy" "backup_service_pass_role_policy" {
  policy = data.aws_iam_policy_document.pass_role_policy_doc.json
  role   = aws_iam_role.aws_backup_service_role.name
}

/* policy for SNS */
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "${local.name}-SnsTopicPolicy"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.alert.arn,
    ]

    sid = "1"
  }
}