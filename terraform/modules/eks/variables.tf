variable "region" {
  description = "AWS region for EKS deployment"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "example-eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the node group"
  default     = "example-node-group"
}

variable "instance_type" {
  description = "Instance type for EKS worker nodes"
  default     = "t3.medium"
}

variable "desired_size" {
  description = "Desired number of nodes"
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes"
  default     = 3
}

variable "min_size" {
  description = "Minimum number of nodes"
  default     = 1
}
