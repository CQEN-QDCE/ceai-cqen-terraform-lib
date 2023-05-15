locals {
    name = "${var.identifier}"
}

#-------------------------------------------------------------------------------
# CodePipeline

resource "aws_iam_policy" "pipeline_role_policy" {
    name = "${local.name}-pipeline-role-policy"
    
    policy = "${(file("${path.module}/policy/pipeline_iam_role_policy.json"))}"  
}

resource "aws_iam_role" "pipeline_role" {
  name = "${local.name}-codepipeline-role"
  assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "codepipeline.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "pipeline_role_policy_attach" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = aws_iam_policy.pipeline_role_policy.arn
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${local.name}-codepipeline-bucket"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${local.name}-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name            = "Source"   
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      
      run_order = 1      
      configuration = {
        "BranchName"     = "${var.aws_codecommit_repository_default_branch}"
        "OutputArtifactFormat" = "CODE_ZIP"
        "PollForSourceChanges" = "false"
        "RepositoryName" = "${var.aws_codecommit_repository_name}"
      }
      output_artifacts = [
        "SourceArtifact"
      ]      
      input_artifacts = []
      namespace = "SourceVariables"
    }
  }
  stage {
    name = "Deploy"
    action {
      name     = "Deploy"
      actionTypeId = {
        category = "Deploy"
        owner    = "AWS"
        provider = "ECS"
        version  = "1"
      }
      run_order = 1
      configuration = {
        ClusterName = "${var.ecs_cluster_name}"
        ServiceName = "${var.ecs_service_name}"
      }
      output_artifacts = []
      input_artifacts = [
        "SourceArtifact"
      ]
      namespace = "DeployVariables"
    }
  }
}