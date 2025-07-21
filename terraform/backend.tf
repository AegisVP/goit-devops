# terraform {
#   backend "s3" {
#     bucket       = "vpysarenko-terraform-state-goit-devops-hw" # Назва S3-бакета
#     key          = "goit-devops-hw/terraform.tfstate"          # Шлях до файлу стейту
#     region       = "us-west-2"                                 # Регіон AWS
#     use_lockfile = true                                        # Назва таблиці DynamoDB
#     encrypt      = true                                        # Шифрування файлу стейту
#   }
# }
