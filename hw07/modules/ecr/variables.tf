variable "ecr_name" {
  description = "Ім'я ECR репозиторію"
  type        = string
}

variable "scan_on_push" {
  description = "Вмикає або вимикає сканування на пуш"
  type        = bool
}
