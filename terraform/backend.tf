# terraform {
#   backend "s3" {
#     bucket       = var.s3_bucket_name                 # Назва S3-бакета
#     key          = "goit-devops-hw/terraform.tfstate" # Шлях до файлу стейту
#     region       = var.aws_region                     # Регіон AWS
#     use_lockfile = true                               # Назва таблиці DynamoDB
#     encrypt      = true                               # Шифрування файлу стейту
#   }
# }
