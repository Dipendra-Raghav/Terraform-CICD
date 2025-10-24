# 🚀 Terraform CI/CD Workflow

## 📋 Branching Strategy

```
feature/* → dev → master
    ↓        ↓       ↓
   CI    Non-Prod  Prod
```

---

## 🌿 Branch Structure

| Branch | Purpose | Deployment Target | Auto-Deploy |
|--------|---------|-------------------|-------------|
| `feature/*` | Development work | None | ❌ No |
| `dev` | Integration/Testing | **Non-Prod** | ✅ Yes |
| `master` | Production-ready | **Prod** | ⏸️ Manual Approval |

---

## 🔄 Complete Workflow

### **Phase 1: Feature Development**

```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes to Terraform code
# Edit files in environments/non-prod/ or modules/

# Commit changes
git add .
git commit -m "feat: add new infrastructure"
git push origin feature/my-feature
```

**What Happens:**
- ❌ No pipeline triggered (feature branch)
- Manual testing on local machine

---

### **Phase 2: Non-Prod Deployment**

```bash
# Create PR: feature/my-feature → dev
# Go to GitHub and create Pull Request
```

**What Happens:**
1. ✅ **CI Pipeline Runs** (on PR creation)
   - Format check
   - Terraform init
   - Terraform validate
   - Terraform plan
   - Plan artifact uploaded
   - Bot comments on PR

2. 👀 **Review PR**
   - Check CI results
   - Review plan artifact
   - Get approval from team

3. ✅ **Merge PR to dev**
   ```bash
   # After PR approval, merge on GitHub
   # Or via CLI:
   git checkout dev
   git merge feature/my-feature
   git push origin dev
   ```

4. 🚀 **CD Pipeline Auto-Deploys to Non-Prod**
   - Triggers on push to `dev` branch
   - Terraform init
   - Terraform plan
   - Terraform apply (auto-approved)
   - Outputs uploaded as artifacts

**Result:** ✅ Infrastructure deployed to **Non-Prod Environment**

---

### **Phase 3: Production Deployment**

```bash
# Create PR: dev → master
# Go to GitHub and create Pull Request
```

**What Happens:**
1. ✅ **CI Pipeline Runs** (on PR creation)
   - Format check
   - Terraform init
   - Terraform validate
   - Terraform plan for PROD
   - Plan artifact uploaded
   - Bot comments on PR

2. 👀 **Thorough Review**
   - Check CI results
   - Review production plan
   - Multiple approvals required
   - Security/compliance checks

3. ✅ **Merge PR to master**
   ```bash
   # After approvals, merge on GitHub
   # Or via CLI:
   git checkout master
   git merge dev
   git push origin master
   ```

4. ⏸️ **CD Pipeline Waits for Manual Approval**
   - Triggers on push to `master` branch
   - Terraform init
   - Terraform plan
   - **⏸️ PAUSES for manual approval**
   - Go to GitHub Actions
   - Click "Review deployments"
   - Click "Approve deployment"

5. 🎯 **Terraform Apply (After Approval)**
   - Terraform apply executes
   - Outputs uploaded as artifacts

**Result:** ✅ Infrastructure deployed to **Production Environment**

---

## 🎯 Quick Reference

### **For Daily Development**
```bash
# 1. Create feature branch
git checkout -b feature/add-security-group

# 2. Make changes
# Edit environments/non-prod/main.tf

# 3. Commit and push
git add .
git commit -m "feat: add security group rules"
git push origin feature/add-security-group

# 4. Create PR to 'dev' on GitHub
# 5. Review CI results
# 6. Merge → Auto-deploys to Non-Prod ✅
```

### **For Production Release**
```bash
# 1. Create PR: dev → master
# 2. Get team approvals
# 3. Merge to master
# 4. Go to Actions → Review deployments → Approve
# 5. Deployed to Production ✅
```

---

## 📊 Pipeline Triggers

### **CI Pipeline (Validation)**
```yaml
Triggers:
  - Pull Request to 'dev'
  - Pull Request to 'master'
  - Push to 'dev'
  - Push to 'master'

Runs:
  - Format check
  - Init
  - Validate
  - Plan
  - Upload artifacts
  - PR comments
```

### **CD Pipeline (Deployment)**
```yaml
Non-Prod:
  Triggers:
    - Push to 'dev' branch
  Auto-Deploy: YES
  Approval: NOT REQUIRED

Production:
  Triggers:
    - Push to 'master' branch
  Auto-Deploy: NO
  Approval: REQUIRED
```

---

## 🔒 Environment Protection Rules

### **Non-Prod Environment**
- ✅ Auto-deploy on merge to `dev`
- ❌ No approval required
- 🔄 Continuous deployment

### **Production Environment**
- ⏸️ Manual approval required
- 👥 Designated approvers only
- 🔒 Protected branch (`master`)

---

## 📁 Repository Structure

```
Terraform-CICD/
├── .github/
│   └── workflows/
│       ├── terraform-ci.yml   # Validation pipeline
│       └── terraform-cd.yml   # Deployment pipeline
├── environments/
│   ├── non-prod/              # Dev branch deploys here
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prod/                  # Master branch deploys here
│       ├── main.tf
│       └── terraform.tfvars
└── modules/
    ├── vpc/
    ├── ec2/
    └── security-group/
```

---

## 🎓 For Manager Demo

### **Demonstrate:**

1. **Feature Development**
   - Create feature branch
   - Make infrastructure changes
   - No deployment yet (safe)

2. **Non-Prod Testing**
   - PR to dev → CI validates
   - Merge → Auto-deploys to non-prod
   - Fast iteration

3. **Production Safety**
   - PR to master → CI validates
   - Merge → Waits for approval
   - Manual gate before production
   - Audit trail

### **Key Points:**
- ✅ Automated validation (CI)
- ✅ Environment isolation
- ✅ Fast non-prod deployments
- ✅ Production safety gates
- ✅ Plan artifacts for review
- ✅ No manual Terraform commands needed

---

## 🚨 Troubleshooting

### **CI doesn't run on feature branch**
- ✅ **Expected behavior** - CI only runs on PRs to dev/master

### **CD doesn't deploy after merge**
- Check branch name (must be `dev` or `master`)
- Check file paths (must change `environments/**` or `modules/**`)

### **Production deployment stuck**
- Go to Actions → Click workflow run
- Click "Review deployments"
- Select "prod" environment
- Click "Approve and deploy"

---

## 📞 Support

For questions, contact the DevOps team or check:
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Terraform Documentation](https://www.terraform.io/docs)
