variable "ecr_name" {
  description = "Ім'я ECR репозиторію"
  type        = string
}

variable "ecr_mutable" {
  description = "Вмикає або вимикає мутабельність тегів контейнерів"
  type        = bool
}

variable "scan_on_push" {
  description = "Вмикає або вимикає сканування на пуш"
  type        = bool
}

variable "ecr_force_delete" {
  description = "Дозволяє видаляти репозиторій з усіма образами"
  type        = bool
  default     = false
}
