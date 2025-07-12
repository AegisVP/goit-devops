# Підключаємо модуль для VPC
module "vpc" {
  source             = "./modules/vpc"                               # Шлях до модуля VPC
  vpc_cidr_block     = "10.0.0.0/16"                                 # CIDR блок для VPC
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Публічні підмережі
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] # Приватні підмережі
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]    # Зони доступності
  vpc_name           = "vpc"                                         # Ім'я VPC
}

# Підключаємо модуль ECR
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "homework-07-ecr"
  ecr_mutable  = true
  scan_on_push = true
}

module "eks" {
  source        = "./modules/eks"
  cluster_name  = "eks-cluster-demo"        # Назва кластера
  subnet_ids    = module.vpc.public_subnets # ID підмереж
  instance_type = "t3.medium"               # Тип інстансів
  desired_size  = 1                         # Бажана кількість нодів
  max_size      = 2                         # Максимальна кількість нодів
  min_size      = 1                         # Мінімальна кількість нодів
}
