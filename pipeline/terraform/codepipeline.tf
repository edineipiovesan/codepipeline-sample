resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project-name}-develop"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      namespace        = "SourceVariables"

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.repository.arn
        FullRepositoryId = var.repository-path
        BranchName       = var.branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.project-name}-build"
      }
    }

    action {
      name            = "Unit-test"
      category        = "Test"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ProjectName = "${var.project-name}-unit-test"
      }
    }
  }

  stage {
    name = "Package"

    action {
      name            = "Package"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output", "build_output"]
      version         = "1"

      configuration = {
        ProjectName   = "${var.project-name}-package"
        PrimarySource = "source_output"
        EnvironmentVariables = jsonencode([{
          name  = "IMAGE_TAG"
          value = "#{SourceVariables.CommitId}"
          type  = "PLAINTEXT"
        }])
      }
    }
  }

  #  stage {
  #    name = "Deploy"
  #
  #    action {
  #      name            = "Deploy"
  #      category        = "Deploy"
  #      owner           = "AWS"
  #      provider        = "CloudFormation"
  #      input_artifacts = ["build_output"]
  #      version         = "1"
  #
  #      configuration = {
  #        ActionMode     = "REPLACE_ON_FAILURE"
  #        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
  #        OutputFileName = "CreateStackOutput.json"
  #        StackName      = "MyStack"
  #        TemplatePath   = "build_output::sam-templated.yaml"
  #      }
  #    }
  #  }
}
