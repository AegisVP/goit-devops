output "ecr_repository_url" {
  description = "URL ECR репозиторію"
  value       = aws_ecr_repository.ecr_repository.repository_url
}

output "ecr_repository_arn" {
  description = "ARN створеного репозиторію."
  value       = aws_ecr_repository.ecr_repository.arn
}
