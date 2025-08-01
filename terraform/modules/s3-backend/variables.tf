variable "bucket_name" {
  description = "Name of the S3 bucket for storing Terraform states"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
}

