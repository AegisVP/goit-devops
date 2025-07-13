# Homework 07

This project provisions an AWS infrastructure using Terraform, including a VPC, ECR repository, and EKS cluster. It also provides a Helm chart to deploy a Django application to the created Kubernetes cluster.

## Installation and Deployment

1. Initialize Terraform:
   `terraform init`

2. Apply the Terraform configuration to create AWS resources:
   `terraform apply`

3. Authenticate Docker to your AWS ECR registry (replace `<aws_ecr_repository_url>` with the actual ECR URL from Terraform output):
   `aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <aws_ecr_repository_url>`

4. Update your kubeconfig to connect to the new EKS cluster (replace `<aws_eks_cluster.eks.name>` with the actual cluster name from Terraform output):
   `aws eks --region us-west-2 update-kubeconfig --name eks-cluster-demo`

5. Build, tag and upload your Docker image to your ECR.
   Put the path in `./chart/values.yaml:image.repository`

6. Deploy the Django application using Helm:
   `cd charts`
   `helm install vp-dja-app .`

7. To verify the project works, run `kubectl get all`, find service/vp-dja-app-django LoadBalancer external uri and enter it in the browser. Make sure to use HTTP as HTTPS is not enabled

8. `kubectl get pods` will show a list of all running pods
