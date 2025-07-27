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

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "vpysarenko-terraform-state-goit-devops-hw"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform_locks"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "goit-devops-hw"
}
