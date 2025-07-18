variable "region" {
  description = "AWS регіон для розгортання EKS"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Назва кластера EKS"
  default     = "example-eks-cluster"
}

variable "subnet_ids" {
  description = "Список ID підмереж для кластера EKS"
  type        = list(string)
}

variable "node_group_name" {
  description = "Назва групи нодів"
  default     = "example-node-group"
}

variable "instance_type" {
  description = "Тип інстансу EKS для робочих нодів"
  default     = "t3.medium"
}

variable "desired_size" {
  description = "Бажана кількість нодів"
  default     = 2
}

variable "max_size" {
  description = "Максимальна кількість нодів"
  default     = 3
}

variable "min_size" {
  description = "Мінімальна кількість нодів"
  default     = 1
}
