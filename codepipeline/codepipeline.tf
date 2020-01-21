provider "github" {
  token        = var.github_oauth_token
  organization = var.repo_owner
}

resource "aws_codepipeline" "default" {
  name     = var.app
  role_arn = aws_iam_role.codebuild_role.arn

  artifact_store {
  location = var.codepipeline_bucket_name
  type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["codepipeline"]

      configuration = {
        Owner                = var.repo_owner
        Repo                 = var.repo_name_back
        PollForSourceChanges = "true"
        Branch               = var.branch
        OAuthToken           = var.github_oauth_token
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
      version          = "1"

      input_artifacts  = ["codepipeline"]

      configuration = {
        ProjectName = aws_codebuild_project.plan.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name      = "ApprovalStage"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      run_order = 1
      version   = "1"
    }

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      run_order       = 2
      version         = "1"
     
      input_artifacts  = ["codepipeline"]  

      configuration = {
        ProjectName = aws_codebuild_project.apply.name
      }
    }
  }
}

locals {
  webhook_secret = "super-secret"
}

resource "aws_codepipeline_webhook" "bar" {
  name            = "test-webhook-github-bar" 
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.default.name

  authentication_configuration {
    secret_token = local.webhook_secret
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}

# Wire the CodePipeline webhook into a GitHub repository.
resource "github_repository_webhook" "test" {
  repository = var.repo_name_back

  configuration {
    url          = aws_codepipeline_webhook.bar.url
    content_type = "json"
    insecure_ssl = true
    secret       = local.webhook_secret
  }

  events = ["push"]
}
