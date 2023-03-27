locals {
  name = "${var.identifier}"
  create_rds_backup = contains(["rds", "all"], var.ressource_type)
  create_efs_backup = contains(["efs", "all"], var.ressource_type)
}

data "aws_kms_key" "aws_backup_key" {
  key_id = "alias/aws/backup"
}

resource "aws_sns_topic" "alert" {
  name = "${local.name}-sns-topic"
  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.backup_alarms_email} --profile ${var.aws_profile}"
  }
}

resource "aws_sns_topic_policy" "topic_policy" {
  arn = aws_sns_topic.alert.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_backup_vault_notifications" "backup_vault_notifications" {
  backup_vault_name   = aws_backup_vault.backup_vault.name
  sns_topic_arn       = aws_sns_topic.alert.arn
  backup_vault_events = ["BACKUP_JOB_FAILED"]
}

resource "aws_backup_vault" "backup_vault" {
  name        = "${local.name}-backup-vault"
  kms_key_arn = data.aws_kms_key.aws_backup_key.arn
  tags = {
    Role = "backup-vault"
  }
}

resource "aws_backup_plan" "backup_plan" {
  name = "${aws_backup_vault.backup_vault.name}-plan"
  dynamic "rule" {
    for_each = var.backup_rules
    content {
      rule_name                = lookup(rule.value, "name", null)
      target_vault_name        = aws_backup_vault.backup_vault.name
      schedule                 = lookup(rule.value, "schedule", null)
      start_window             = lookup(rule.value, "start_window", null)
      completion_window        = lookup(rule.value, "completion_window", null)
      enable_continuous_backup = lookup(rule.value, "enable_continuous_backup", null)
      recovery_point_tags = {
        Frequency  = lookup(rule.value, "name", null)
        Created_By = "aws-backup"
      }
      lifecycle {
        delete_after = lookup(rule.value, "delete_after", null)
      }
    }
  }
}

resource "aws_backup_selection" "backup_rds" {
  count = local.create_rds_backup ? 1 : 0
  iam_role_arn = aws_iam_role.aws-backup-service-role.arn
  name         = "${local.name}-rds"
  plan_id      = aws_backup_plan.backup_plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "True"
  }
  resources = [
    var.rds_arn
 ]
 depends_on = [
    var.rds_arn
  ]
}

data "aws_efs_file_system" "data_efs" {
  for_each = {for fs in var.efs_arn : fs.id => fs if contains(keys(fs.tags), "Tag") && fs.tags.Tag == var.backup_efs_tag}
              
  file_system_id = each.value.id

  depends_on = [
    var.efs_arn
  ]
}

resource "aws_backup_selection" "backup_efs" {
  count = local.create_efs_backup ? 1 : 0
  iam_role_arn = aws_iam_role.aws-backup-service-role.arn
  name         = "${local.name}-data-efs"
  plan_id      = aws_backup_plan.backup_plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "True"
  }
  resources = [for fs in data.aws_efs_file_system.data_efs : fs.arn] 
    depends_on = [
    var.efs_arn, data.aws_efs_file_system.data_efs
  ]
}