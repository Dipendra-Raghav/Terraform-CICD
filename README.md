# Terraform CI/CD with Separate Environments
changes
changes
changes
changes

Simple, clean Terraform structure with GitHub Actions CI/CD for non-prod and prod environments.

## 📁 Project Structure

```
Terraform-CICD/
├── modules/                    # Shared reusable modules
│   ├── vpc/
│   ├── ec2/
│   └── security-group/
│
├── environments/               # Each environment is independent
│   ├── non-prod/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       └── terraform.tfvars
│
└── .github/workflows/
    ├── terraform-ci.yml        # CI Pipeline
    └── terraform-cd.yml        # CD Pipeline
```

## 🚀 Quick Start

### 1. Local Testing

```bash
# Test non-prod
cd environments/non-prod
terraform init
terraform plan
terraform apply

# Test prod
cd environments/prod
terraform init
terraform plan
terraform apply
```

### 2. Setup GitHub

```bash
# Commit and push
git add .
git commit -m "feat: initial terraform setup"
git push origin main
```

### 3. Configure GitHub Secrets

Add these secrets in: **Settings → Secrets and variables → Actions**

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## 🔄 CI/CD Flow

### On Push or PR:
1. **Detects** which environment changed
2. **Runs CI** for that environment:
   - Format check
   - Init
   - Validate
   - Plan
   - Upload artifact
   - Comment on PR

### On Merge to Main:
1. **Deploys non-prod** automatically
2. **Prod deployment** requires manual trigger

### Manual Deployment:
Go to Actions → Terraform CD → Run workflow → Select environment

## 🌍 Environments

### Non-Prod
- VPC: 10.0.0.0/16
- 2 AZs (us-east-1a, us-east-1b)
- 1x t3.micro instance

### Prod
- VPC: 10.1.0.0/16
- 3 AZs (us-east-1a, us-east-1b, us-east-1c)
- 2x t3.small instances

## 📝 Commands

```bash
# Format all files
terraform fmt -recursive

# Test specific environment
cd environments/non-prod
terraform init
terraform plan
terraform apply
terraform destroy

# Switch to prod
cd ../prod
terraform init
terraform plan
```

## ✅ Benefits of This Structure

- ✅ **Complete isolation** - Each environment is independent
- ✅ **No workspace confusion** - Separate directories
- ✅ **Different configs** - Each env can have unique resources
- ✅ **Safe deployments** - Can't accidentally destroy wrong env
- ✅ **Simple CI/CD** - Detects changes automatically

## 🔒 What Gets Deployed

Each environment creates:
- VPC with public/private subnets
- Internet Gateway
- Route tables
- Security groups (SSH, HTTP)
- EC2 instances with Apache web server

## 🧹 Cleanup

```bash
# Destroy non-prod
cd environments/non-prod
terraform destroy

# Destroy prod
cd environments/prod
terraform destroy
```

## 📚 Key Files

- `modules/*/main.tf` - Reusable module code
- `environments/*/main.tf` - Environment-specific infrastructure
- `environments/*/terraform.tfvars` - Environment-specific values
- `.github/workflows/*.yml` - CI/CD pipelines

---

**Simple. Clean. Production-Ready.** 🚀
