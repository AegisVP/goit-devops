variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "github_repo" {
  description = "GitHub repository URL"
  type        = string
}

variable "github_login" {
  description = "GitHub login name"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}
