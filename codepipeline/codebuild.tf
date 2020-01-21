provider "aws" {
  region     = var.region
}

resource "aws_codebuild_project" "plan" {
  name          = "build"
  description   = "CodeBuild Project for Terraform Plan"
  build_timeout = "12"
  service_role  = aws_iam_role.codebuild_role.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:2.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true    

  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec_test.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }
}

resource "aws_codebuild_project" "apply" {
  name          = "deploy"
  description   = "CodeBuild Project for Terraform Apply"
  build_timeout = "12"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
   type = "CODEPIPELINE"
   }
  
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE", "LOCAL_CUSTOM_CACHE"]
   }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:2.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true   

    environment_variable {
      name  = "ENVIRONMENT"
      value = "prod"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec_apply.yml"
  }
}
