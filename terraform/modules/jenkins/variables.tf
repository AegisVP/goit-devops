variable "namespace" {
  description = "Назва простору імен Kubernetes для Jenkins"
  type        = string
  default     = "jenkins"
}

variable "cluster_name" {
  description = "Назва Kubernetes кластера"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN OIDC провайдера для IRSA"
  type        = string

}

variable "oidc_provider_url" {
  description = "URL OIDC провайдера для IRSA"
  type        = string
}

variable "github_login" {
  description = "Github Username"
  type        = string
}

variable "github_token" {
  description = "Github PAT"
  type        = string
}

variable "github_repo" {
  description = "Github Repository URL"
  type        = string
}

variable "github_branch" {
  description = "Github Branch"
  type        = string
}
