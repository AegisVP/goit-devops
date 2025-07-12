resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.ecr_name
  image_tag_mutability = var.ecr_mutable ? "MUTABLE" : "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
