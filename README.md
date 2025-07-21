# Homework 09

This project provisions an AWS infrastructure using Terraform, including a VPC, ECR repository, and EKS cluster. It also provides a Helm chart to deploy a Django application to the created Kubernetes cluster.

## Installation and Deployment

1. Initialize Terraform:
   `terraform init`

2. If you don't have an ECR, you can use `terraform apply -target module.ecr` or create it manually. Note the ECR URL

3. Authenticate Docker to your AWS ECR (replace `<aws_ecr_url>` with the actual ECR URL from above):
   `aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <aws_ecr_url>` # 033491664040.dkr.ecr.us-west-2.amazonaws.com/goit-devops-hw

4. Build, tag and push your Docker image to your ECR:
   `docker tag <your_local_image> <aws_ecr_url>` and `docker push <aws_ecr_url>`
   Put the path in `./chart/values.yaml:image.repository`

5. Apply the Terraform configuration to create other AWS resources:
   `terraform apply`

6. Update your kubeconfig to connect to the new EKS cluster (replace `<aws_eks_cluster.eks.name>` with the actual cluster name from Terraform output):
   `aws eks --region us-west-2 update-kubeconfig --name <aws_eks_cluster.eks.name>` # eks-vp

7. `kubectl get svc -A` - get all pods in all namespaces with URLs to access Jenkins, Argo-CD and the project itself.

8. To get Argo-CD admin password, run `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

9. After installation, need to open Jenkins, allow the script and run `seed-job` and then `goit-django-docker` to build the image.
