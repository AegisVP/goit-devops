# terraform {
#   backend "s3" {
#     bucket         = "pysarenko_terraform_states_hw05" # Назва S3-бакета
#     key            = "hw05/terraform.tfstate"          # Шлях до файлу стейту
#     region         = "us-west-2"                       # Регіон AWS
#     dynamodb_table = "terraform-locks"                 # Назва таблиці DynamoDB
#     encrypt        = true                              # Шифрування файлу стейту
#   }
# }
