# Terraform Infrastructure Project

This Terraform project sets up a complete AWS infrastructure with modular components for homework assignment 05. The project creates a VPC with public and private subnets, an ECR repository for container images, and an S3 backend with DynamoDB for Terraform state management.

## 🏗️ Project Structure

```
hw05/
├── main.tf                 # Main Terraform configuration
├── backend.tf              # Backend configuration (commented out)
├── terraform.tfstate       # Terraform state file
├── terraform.tfstate.backup # Terraform state backup
└── modules/
    ├── ecr/                # ECR repository module
    │   ├── ecr.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── s3-backend/         # S3 backend and DynamoDB module
    │   ├── dynamodb.tf
    │   ├── outputs.tf
    │   ├── s3.tf
    │   └── variables.tf
    └── vpc/                # VPC and networking module
        ├── outputs.tf
        ├── routes.tf
        ├── variables.tf
        └── vpc.tf
```

## 🚀 Features

### 1. **VPC Module** (`modules/vpc/`)
- Creates a custom VPC with configurable CIDR block
- Sets up public and private subnets across multiple availability zones
- Configures route tables for internet connectivity
- Supports 3 availability zones (us-west-2a, us-west-2b, us-west-2c)

**Network Configuration:**
- VPC CIDR: `10.0.0.0/16`
- Public Subnets: `10.0.1.0/24`, `10.0.2.0/24`, `10.0.3.0/24`
- Private Subnets: `10.0.4.0/24`, `10.0.5.0/24`, `10.0.6.0/24`

### 2. **ECR Module** (`modules/ecr/`)
- Creates an Amazon Elastic Container Registry repository
- Enables image scanning on push for security
- Repository name: `homework-05-ecr`

### 3. **S3 Backend Module** (`modules/s3-backend/`)
- Creates an S3 bucket for Terraform state storage
- Sets up DynamoDB table for state locking
- Enables versioning and encryption for security
- Bucket name: `pysarenko-terraform-states-hw05`
- DynamoDB table: `terraform-locks`

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (version >= 1.0)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions for:
  - VPC creation and management
  - ECR repository creation
  - S3 bucket creation and management
  - DynamoDB table creation

## 🛠️ Installation and Usage

### 1. Clone the repository
```bash
git clone git@github.com:AegisVP/goit-devops.git
cd /hw05
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the plan
```bash
terraform plan
```

### 4. Apply the configuration
```bash
terraform apply
```

### 5. To destroy the infrastructure
```bash
terraform destroy
```

## 🔧 Configuration

### Backend Configuration
The backend configuration is currently commented out in `backend.tf`. To enable remote state storage:

1. Uncomment the backend configuration in `backend.tf`
2. Update the bucket name and region as needed
3. Run `terraform init` again

```hcl
terraform {
  backend "s3" {
    bucket         = "pysarenko_terraform_states_hw05"
    key            = "hw05/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

### Customizing the Infrastructure

You can modify the following variables in `main.tf`:

- **VPC Configuration:**
  - `vpc_cidr_block`: Change the VPC CIDR block
  - `public_subnets`/`private_subnets`: Modify subnet CIDR blocks
  - `availability_zones`: Change AWS availability zones
  - `vpc_name`: Customize VPC name

- **ECR Configuration:**
  - `ecr_name`: Change the ECR repository name
  - `scan_on_push`: Enable/disable image scanning

- **S3 Backend Configuration:**
  - `s3_bucket_name`: Change the S3 bucket name
  - `dynamodb_table_name`: Change the DynamoDB table name

## 📊 Outputs

The modules provide various outputs that can be used by other modules or for reference:

- **VPC Module:** VPC ID, subnet IDs, route table IDs
- **ECR Module:** Repository URL, repository ARN
- **S3 Backend Module:** S3 bucket name, DynamoDB table name

## 🔒 Security Features

- S3 bucket versioning enabled
- S3 bucket encryption enabled
- DynamoDB table for state locking
- ECR image scanning on push
- Private subnets for sensitive resources

## 🧹 Cleanup

To completely remove all created resources:

```bash
terraform destroy
```

**⚠️ Warning:** This will delete all resources created by this Terraform configuration, including the S3 bucket and DynamoDB table.

## 📝 Notes

- The project is configured for the `us-west-2` AWS region
- All resources are tagged appropriately for cost tracking
- The infrastructure follows AWS best practices for security and scalability
- State files are stored locally by default (backend configuration is commented out)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan` and `terraform apply`
5. Submit a pull request

## 📄 License

This project is part of the GoIT DevOps course homework assignment.
