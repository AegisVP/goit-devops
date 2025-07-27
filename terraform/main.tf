# # Importing S3 and DynamoDB
# import {
#   to = module.s3_backend.aws_s3_bucket.terraform_state
#   id = var.s3_bucket_name
# }

# import {
#   to = module.s3_backend.aws_dynamodb_table.terraform_locks
#   id = var.dynamodb_table_name
# }

# # Creating S3 and DynamoDB
# module "s3_backend" {
#   source      = "./modules/s3-backend"  # Path to module
#   bucket_name = var.s3_bucket_name      # Name of S3 bucket
#   table_name  = var.dynamodb_table_name # Name of DynamoDB
# }

# Creating VPC
module "vpc" {
  source             = "./modules/vpc"                                                    # Path to the VPC module
  vpc_cidr_block     = "10.0.0.0/16"                                                      # CIDR block for VPC
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]                      # Public subnets
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]                      # Private subnets
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"] # Accessibility zones
  vpc_name           = "goit-hw"                                                          # Name of VPC
}

# Importing ECR
import {
  to = module.ecr.aws_ecr_repository.ecr_repository
  id = var.ecr_repository_name
}

# Creating ECR
module "ecr" {
  source           = "./modules/ecr"
  ecr_name         = var.ecr_repository_name
  ecr_mutable      = true
  scan_on_push     = true
  ecr_force_delete = true
}

# Creating EKS
module "eks" {
  source        = "./modules/eks"
  cluster_name  = "eks-vp"
  subnet_ids    = module.vpc.public_subnets
  instance_type = "t3.medium"
  desired_size  = 1
  max_size      = 3
  min_size      = 1
}

module "rds" {
  source = "./modules/rds"

  name                  = "myapp-db"
  use_aurora            = false
  aurora_instance_count = 2

  # --- Aurora-only ---
  engine_cluster                = "aurora-postgresql"
  engine_version_cluster        = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"

  # --- RDS-only ---
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"

  # Common
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  db_name                 = "myapp"
  username                = "postgres"
  password                = "admin123AWS23"
  subnet_private_ids      = module.vpc.private_subnets
  subnet_public_ids       = module.vpc.public_subnets
  publicly_accessible     = true
  vpc_id                  = module.vpc.vpc_id
  multi_az                = true
  backup_retention_period = 7
  parameters = {
    max_connections            = "200"
    log_min_duration_statement = "500"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}

data "aws_eks_cluster" "eks" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks" {
  name       = module.eks.eks_cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# Creating Jenkins
module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.eks_cluster_name
  namespace         = "jenkins"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  github_login      = var.github_login
  github_token      = var.github_token
  github_repo       = var.github_repo
  github_branch     = "homework09" # after MR is merged, this will be 'main'
  depends_on        = [module.eks]

  providers = {
    helm       = helm
    kubernetes = kubernetes
  }
}

# Creating Argo-CD
module "argo-cd" {
  source        = "./modules/argo-cd"
  namespace     = "argocd"
  chart_version = "8.1.3"
  github_repo   = var.github_repo
  github_branch = "homework09" # after MR is merged, this will be 'main'
  depends_on    = [module.eks]
}
