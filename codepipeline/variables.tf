variable "repo_owner" {
default = "kirill-yasko-axon"
}

variable "github_oauth_token" {}

variable "project" {
        default = "ziqy-codepipeline"
}

variable "account_id" {
default = "ziqy" 
}

variable codepipeline_bucket_name {
default = "ziqy-s3-artifacts"
}

variable "app" {
        default = "ziqy-app"
}

variable "docker_build_image" {
  default = "ubuntu"
}

variable "repo_name_back" {
default = "ziqy-client-platform"
}

variable "webhook_authentication" {
  type        = string
  description = "The type of authentication to use. One of IP, GITHUB_HMAC, or UNAUTHENTICATED"
  default     = "GITHUB_HMAC"
}

variable "webhook_filter_json_path" {
  type        = string
  description = "The JSON path to filter on"
  default     = "$.ref"
}

variable "webhook_filter_match_equals" {
  type        = string
  description = "The value to match on (e.g. refs/heads/{Branch})"
  default     = "refs/heads/{Branch}"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Enable `CodePipeline` creation"
}


variable "region" {
default = "eu-central-1"
}

variable "branch" {
default = "master"
}
