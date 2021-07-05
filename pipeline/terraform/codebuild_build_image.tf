resource "aws_codebuild_project" "package" {
  name          = "${var.project-name}-package"
  description   = "Build docker image"
  build_timeout = "5"
  service_role  = aws_iam_role.codepipeline_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "DOCKERHUB_USERNAME"
      value = var.dockerhub-username-arn
      type  = "SECRETS_MANAGER"
    }
    environment_variable {
      name  = "DOCKERHUB_PASSWORD"
      value = var.dockerhub-password-arn
      type  = "SECRETS_MANAGER"
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.project-name
    }
    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "${var.project-name}-codebuild"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "pipeline/buildspec/package.yml"
  }
}