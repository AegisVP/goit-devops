variable "name" {
  description = "Назва Helm-релізу"
  type        = string
  default     = "argo-cd"
}

variable "namespace" {
  description = "K8s namespace для Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Версія Argo CD чарта"
  type        = string
  default     = "8.1.3"
}

variable "github_repo" {
  description = "Github Repository URL"
  type        = string
}

variable "github_branch" {
  description = "Github Branch"
  type        = string
}
