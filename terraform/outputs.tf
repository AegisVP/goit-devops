output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  value = module.eks.eks_node_role_arn
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "ecr_repository_arn" {
  value = module.ecr.ecr_repository_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "jenkins_release" {
  value = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  value = module.jenkins.jenkins_namespace
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  value = module.eks.oidc_provider_url
}

output "argo_cd_server_service" {
  value = module.argo-cd.argo_cd_server_service
}

output "admin_password" {
  value = module.argo-cd.admin_password
}
