# AWS Terravault Grid

## Infrastructure as Code (IaC) for Core Cloud Resources

AWS Terravault Grid is a modular Infrastructure-as-Code project built using Terraform and AWS services.

The project provisions core cloud infrastructure resources including networking, compute, storage, database, remote state management, and Policy-as-Code governance using OPA.

---

# Project Overview

This project provisions:

- VPC networking infrastructure
- Public and private subnets
- Route tables and Internet Gateway
- EC2 compute resources
- PostgreSQL RDS database
- S3 storage buckets
- Remote Terraform state backend
- DynamoDB state locking
- OPA Policy-as-Code validation

---

# Project Objectives

The project demonstrates:

- Infrastructure provisioning using Terraform
- Modular Infrastructure-as-Code architecture
- Remote state management using S3
- State locking using DynamoDB
- Cloud governance using OPA
- AWS infrastructure deployment automation

---

# AWS Services Used

| Service | Purpose |
|---|---|
| Amazon VPC | Networking infrastructure |
| Amazon EC2 | Compute resources |
| Amazon RDS PostgreSQL | Database service |
| Amazon S3 | Object storage and Terraform backend |
| Amazon DynamoDB | Terraform state locking |
| AWS IAM | Access management |

---

# Project Architecture

```text
                           INTERNET
                               │
                    terravault-edge-gateway
                         Internet Gateway
                               │
        ┌─────────────────────────────────────┐
        │         terravault-core-vpc         │
        │            172.28.0.0/16            │
        └─────────────────────────────────────┘
                     │                 │
         ┌─────────────────┐ ┌─────────────────┐
         │ ingress-segment │ │ runtime-segment │
         │ Public Subnet   │ │ Private Subnet  │
         └─────────────────┘ └─────────────────┘
                    │
         ┌──────────────────┐
         │ gateway-node     │
         │ EC2 t3.micro     │
         └──────────────────┘

                    │
         ┌────────────────────────┐
         │ persistence-engine     │
         │ PostgreSQL db.t3.micro │
         └────────────────────────┘
```

---

# Project Directory Structure

```text
aws-terravault-grid/
│
├── backend-bootstrap/
│   ├── backend.tf
│   ├── dynamodb.tf
│   ├── outputs.tf
│   └── provider.tf
│
├── deployment-environments/
│   └── sandbox/
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── reusable-modules/
│   ├── compute-mesh/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── database-layer/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── network-fabric/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── security-boundary/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── storage-vault/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── governance-policies/
│   ├── deny-public-db.rego
│   ├── mandatory-tags.rego
│   └── restrict-open-ssh.rego
│
├── automation-scripts/
│   ├── deploy.ps1
│   ├── init.ps1
│   └── validate.ps1
│
├── documentation-assets/
│   ├── screenshots/
│   └── deployment-guide.md
│
├── .gitignore
└── README.md
```

---

# Terraform Modules

| Module | Description |
|---|---|
| network-fabric | Creates VPC, subnets, route tables, and Internet Gateway |
| security-boundary | Creates security groups |
| compute-mesh | Deploys EC2 instance |
| database-layer | Deploys PostgreSQL RDS |
| storage-vault | Creates S3 storage bucket |

---

# Remote State Configuration

Terraform remote state is configured using:

- Amazon S3 bucket
- DynamoDB lock table

This enables:

- Centralized state management
- State locking
- Infrastructure consistency

---

# Policy-as-Code (OPA)

OPA policies implemented:

| Policy | Purpose |
|---|---|
| deny-public-db.rego | Prevents public RDS exposure |
| mandatory-tags.rego | Enforces mandatory tags |
| restrict-open-ssh.rego | Detects open SSH access |

---

# Deployment Instructions

## Step 1 — Clone Repository

```powershell
git clone https://github.com/srita2003/aws-terravault-grid.git
```

## Step 2 — Navigate to Project Directory

```powershell
cd aws-terravault-grid
```

## Step 3 — Configure AWS CLI

```powershell
aws configure
```

Provide:

- AWS Access Key
- AWS Secret Key
- Default region: us-east-1
- Output format: json

## Step 4 — Deploy Backend Infrastructure

```powershell
cd backend-bootstrap

terraform init

terraform apply
```

Type:

```powershell
yes
```

## Step 5 — Deploy Main Infrastructure

```powershell
cd ..

cd deployment-environments/sandbox

terraform init

terraform validate

terraform plan

terraform apply
```

Type:

```powershell
yes
```

---

# OPA Validation

Create a sample input file:

```json
{
  "resource": {
    "aws_db_instance": {
      "publicly_accessible": true
    }
  }
}
```

Run OPA evaluation:

```powershell
opa eval --data governance-policies --input sample.json "data.terraform.guardrails.deny"
```

---

# Terraform Commands

## Initialize Terraform

```powershell
terraform init
```

## Validate Terraform Configuration

```powershell
terraform validate
```

## Preview Infrastructure Changes

```powershell
terraform plan
```

## Deploy Infrastructure

```powershell
terraform apply
```

## Destroy Infrastructure

```powershell
terraform destroy
```

---

# Deployment Verification

After deployment, verify the following resources from the AWS Console:

- VPC
- Public Subnet
- Private Subnet
- Route Table
- Internet Gateway
- EC2 Instance
- PostgreSQL RDS Instance
- S3 Buckets
- DynamoDB Lock Table

---

# OPA Policies Included

| Policy File | Validation |
|---|---|
| deny-public-db.rego | Blocks public database exposure |
| mandatory-tags.rego | Ensures Name tags exist |
| restrict-open-ssh.rego | Detects unrestricted SSH access |

---

# Git Commands

## Initialize Repository

```powershell
git init
```

## Add Project Files

```powershell
git add .
```

## Commit Changes

```powershell
git commit -m "Initial commit for aws-terravault-grid"
```

## Push to GitHub

```powershell
git remote add origin https://github.com/srita2003/aws-terravault-grid.git

git branch -M main

git push -u origin main
```

---

# Deployment Outputs

After successful deployment, Terraform provisions:

- VPC infrastructure
- Public and private subnets
- Internet Gateway
- Route tables
- EC2 compute instance
- PostgreSQL RDS database
- S3 backend bucket
- DynamoDB lock table

---

# Author

**Debasrita Chattopadhyay**