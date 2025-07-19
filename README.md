# GoIT Neoversity homeworks

## Homework 10 (RDS)

_\* all other modules are disabled to prevent errors (because HW09 is not complete) and to speed up installation_

1. Choose if you want Aurora or RDS instance. Modify `/terraform/main.tf` and set the `useAurora` variable in `module "rds"` definition section (`true` for Aurora, `false` for RDS) and save the file

2. Initialize Terraform with `terraform init`

3. Apply the Terraform configuration to create AWS resources `terraform apply`

---

## Homework 09 (Jenkins and Argo-CD)

This project provisions an AWS infrastructure using Terraform, including a VPC, ECR repository, and EKS cluster. It also provides a Helm chart to deploy a Django application to the created Kubernetes cluster.

## Installation and Deployment

1. Initialize Terraform:
   `terraform init`

2. Apply the Terraform configuration to create AWS resources:
   `terraform apply`

   2.1. You can use `terraform apply -target module.ecr` to first create the ECR registry to push your docker image and have the repository url for future steps

3. Authenticate Docker to your AWS ECR registry (replace `<aws_ecr_repository_url>` with the actual ECR URL from Terraform output):
   `aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <aws_ecr_repository_url>` # 033491664040.dkr.ecr.us-west-2.amazonaws.com/goit-devops-hw

4. Update your kubeconfig to connect to the new EKS cluster (replace `<aws_eks_cluster.eks.name>` with the actual cluster name from Terraform output):
   `aws eks --region us-west-2 update-kubeconfig --name <aws_eks_cluster.eks.name>` # eks-cluster-demo

5. Build, tag and upload your Docker image to your ECR.
   Put the path in `./chart/values.yaml:image.repository`

6. `kubectl get svc -A` - get all pods in all namespaces with URLs to access Jenkins, Argo-CD and the project itself.

7. To get Argo-CD admin password, run `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
