locals {
    name = "${var.identifier}"
}

data "aws_caller_identity" "current" {}

#-------------------------------------------------------------------------------
# CodeCommit
resource "aws_codecommit_repository" "img_definition_repository" {
  repository_name = "${local.name}-img-def-codebuild-repo"
  description     = "Repo AWS CodeBuild de la définition de l'image docker de l'application."
  default_branch  = "main"
}

#-------------------------------------------------------------------------------
# Secrets
resource "aws_secretsmanager_secret" "codebuild_secret" {
  name = "${local.name}-codebuild-secret1"
}

resource "aws_secretsmanager_secret_version" "codebuild_secret" {
  secret_id = aws_secretsmanager_secret.codebuild_secret.id
  secret_string = jsonencode(
    {
      "APP_NAME": "${var.app_name}",
      "ECR_REPO_NAME": "${var.app_ecr_repository_name}",      
      "ECS_CONTAINER_NAME": "${var.app_ecs_container_name}",
      "CODECOMMIT_REPO_NAME": aws_codecommit_repository.img_definition_repository.repository_name,
      "CODECOMMIT_COMMIT_MESSAGE": "${local.name}_codebuild_commit",
      "ACCOUNT_ID": data.aws_caller_identity.current.account_id,
      "CODECOMMIT_BRANCH": "main"
    }
  )
 depends_on = [ aws_secretsmanager_secret.codebuild_secret ]
}

#-------------------------------------------------------------------------------
# IAM
resource "aws_iam_policy" "codebuild_role_policy" {
    name = "${local.name}-codebuild-role-policy"
    
    policy = "${(file("${path.module}/policy/codebuild_iam_role_policy.json"))}"  
}

resource "aws_iam_role" "codebuild_role" {
  name = "${local.name}-codebuild-role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "codebuild.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "codebuild_role_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_role_policy.arn
}

#-------------------------------------------------------------------------------
# S3
resource "aws_s3_bucket" "codebuild_bucket" {
  bucket = "${local.name}-bucket"
}

#-------------------------------------------------------------------------------
# Codebuild
resource "aws_codebuild_project" "codebuild_project" {
  name          = "${local.name}-codebuild-project"
  description = "Build project on ${local.name} infra repository"
  source {
    type = "GITHUB"
    location = "${var.github_repo_url}"
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = false
    }
    buildspec = "${var.app_buildspec_path}"
    report_build_status = true 
    insecure_ssl = false
  }
  source_version = "${var.github_repo_branch}"
  artifacts {
    type = "S3"
    location = "${aws_s3_bucket.codebuild_bucket.id}"
    path = ""
    namespace_type = "NONE"
    name = "codebuild-artifacts"
    packaging = "NONE"
    override_artifact_name = false
    encryption_disabled = false
  }
  cache {
    type = "NO_CACHE"
  }
  environment {
    type = "LINUX_CONTAINER"
    image = "aws/codebuild/standard:6.0"
    compute_type = "BUILD_GENERAL1_SMALL"
    
    environment_variable {
        name = "APP_CODEBUILD_SECRET_ID" 
        value = "${aws_secretsmanager_secret.codebuild_secret.id}"      
    }

    privileged_mode = true
    image_pull_credentials_type = "CODEBUILD"
  }
  service_role = aws_iam_role.codebuild_role.arn
  build_timeout = 60
  badge_enabled = false
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      status = "DISABLED"
    }
  }
}

resource "aws_codebuild_webhook" "ci_cd_webhook" {
  project_name = aws_codebuild_project.codebuild_project.name
  build_type = "BUILD"
  filter_group {
    filter {
        type = "EVENT"
        pattern = "PUSH"
        exclude_matched_pattern = false
    }
    filter {
        type = "FILE_PATH"
        pattern = "${var.app_path}/*"
        exclude_matched_pattern = false    
    }
    filter {
        type = "FILE_PATH"
        pattern = "${var.app_path}/*.md"
        exclude_matched_pattern = true      
    }
  }
}