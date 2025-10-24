# ⚡ Quick Start Guide

## 🎯 Current Setup

✅ **Branches Created:**
- `master` - Production branch
- `dev` - Non-prod integration branch  
- `feature/test-pipeline` - Your current feature branch

✅ **Workflows Configured:**
- CI Pipeline - Validates code on PRs
- CD Pipeline - Deploys based on branch

---

## 🚀 Next Steps - Test the Workflow

### **Step 1: Create PR (feature → dev)**

```bash
# You're currently on dev branch, switch to feature branch
git checkout feature/test-pipeline

# Go to GitHub and create Pull Request:
# From: feature/test-pipeline
# To: dev
```

**GitHub URL:**
```
https://github.com/Dipendra-Raghav/Terraform-CICD/compare/dev...feature/test-pipeline
```

**What will happen:**
- ✅ CI pipeline runs
- ✅ Validates Terraform code
- ✅ Generates plan for non-prod
- ✅ Bot comments on PR
- ✅ Plan artifact uploaded

---

### **Step 2: Review & Merge to dev**

1. Check CI results (should all be ✅ green)
2. Review the plan in PR comments
3. Click **"Merge pull request"**
4. Click **"Confirm merge"**

**What will happen:**
- 🚀 CD pipeline triggers automatically
- 🚀 Deploys to **Non-Prod** environment
- 📦 Terraform apply runs
- 📊 Outputs saved as artifacts

---

### **Step 3: Create PR (dev → master)**

After testing in non-prod:

```bash
# Go to GitHub and create Pull Request:
# From: dev
# To: master
```

**GitHub URL:**
```
https://github.com/Dipendra-Raghav/Terraform-CICD/compare/master...dev
```

**What will happen:**
- ✅ CI pipeline runs
- ✅ Validates Terraform code
- ✅ Generates plan for **PROD**
- ✅ Bot comments on PR
- ✅ Plan artifact uploaded

---

### **Step 4: Review & Merge to master**

1. **Thorough review** of production plan
2. Get approvals from team
3. Click **"Merge pull request"**
4. Click **"Confirm merge"**

**What will happen:**
- ⏸️ CD pipeline triggers but **PAUSES**
- ⏸️ Waits for manual approval

---

### **Step 5: Approve Production Deployment**

1. Go to: https://github.com/Dipendra-Raghav/Terraform-CICD/actions
2. Click on the running "Terraform CD" workflow
3. Click **"Review deployments"** button
4. Select **"prod"** environment
5. Add comment (optional)
6. Click **"Approve and deploy"**

**What will happen:**
- 🎯 Terraform apply executes
- 🎯 Deploys to **Production**
- 📊 Outputs saved as artifacts

---

## 📊 Visual Workflow

```
┌─────────────────────────────────────────────────────────┐
│  Step 1: Feature Development                            │
│  ┌──────────────────────────────────────────────────┐   │
│  │ feature/test-pipeline                            │   │
│  │ - Make changes                                   │   │
│  │ - Commit & push                                  │   │
│  │ - No deployment                                  │   │
│  └──────────────────────────────────────────────────┘   │
│                        ↓                                 │
│                    Create PR                             │
│                        ↓                                 │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  Step 2: Non-Prod Testing                               │
│  ┌──────────────────────────────────────────────────┐   │
│  │ PR: feature/test-pipeline → dev                  │   │
│  │ ✅ CI runs (fmt, init, validate, plan)          │   │
│  │ 💬 Bot comments                                  │   │
│  └──────────────────────────────────────────────────┘   │
│                        ↓                                 │
│                    Merge PR                              │
│                        ↓                                 │
│  ┌──────────────────────────────────────────────────┐   │
│  │ dev branch (push event)                          │   │
│  │ 🚀 CD runs                                       │   │
│  │ 🎯 Auto-deploys to NON-PROD                     │   │
│  │ ✅ No approval needed                            │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  Step 3: Production Release                             │
│  ┌──────────────────────────────────────────────────┐   │
│  │ PR: dev → master                                 │   │
│  │ ✅ CI runs (fmt, init, validate, plan)          │   │
│  │ 💬 Bot comments                                  │   │
│  └──────────────────────────────────────────────────┘   │
│                        ↓                                 │
│                    Merge PR                              │
│                        ↓                                 │
│  ┌──────────────────────────────────────────────────┐   │
│  │ master branch (push event)                       │   │
│  │ 🚀 CD runs                                       │   │
│  │ ⏸️  PAUSES - Needs Approval                      │   │
│  └──────────────────────────────────────────────────┘   │
│                        ↓                                 │
│                Manual Approval                           │
│                        ↓                                 │
│  ┌──────────────────────────────────────────────────┐   │
│  │ 🎯 Deploys to PRODUCTION                         │   │
│  │ ✅ Approved by authorized person                 │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 🔑 Key Commands

### **Start New Feature**
```bash
git checkout dev
git pull origin dev
git checkout -b feature/my-new-feature
# Make changes
git add .
git commit -m "feat: describe your changes"
git push origin feature/my-new-feature
# Create PR to 'dev' on GitHub
```

### **Deploy to Non-Prod**
```bash
# Just merge PR (feature → dev)
# CD pipeline auto-deploys ✅
```

### **Deploy to Production**
```bash
# 1. Merge PR (dev → master)
# 2. Go to Actions tab
# 3. Click "Review deployments"
# 4. Approve
```

---

## 📋 Checklist for First Run

- [ ] Create PR: `feature/test-pipeline` → `dev`
- [ ] Review CI results (should all pass ✅)
- [ ] Merge PR
- [ ] Check Actions tab - Non-prod deployment should run
- [ ] Verify deployment in Actions logs
- [ ] Create PR: `dev` → `master`
- [ ] Review CI results for prod plan
- [ ] Merge PR
- [ ] Go to Actions → Review deployments
- [ ] Approve production deployment
- [ ] Verify production deployment completes

---

## 🎓 Demo Script for Manager

### **Intro (1 min)**
"I've set up a complete Terraform CI/CD pipeline with proper environment isolation and approval gates."

### **Show Feature Development (2 min)**
1. "Here's a feature branch with infrastructure changes"
2. "I create a PR to dev branch"
3. "CI automatically validates the code"
4. "See the plan in the PR comments"

### **Show Non-Prod Deployment (2 min)**
1. "I merge the PR"
2. "Watch - it auto-deploys to non-prod"
3. "No manual intervention needed"
4. "Perfect for fast iteration"

### **Show Production Safety (3 min)**
1. "After testing, I create PR to master"
2. "CI validates again with production plan"
3. "I merge after approvals"
4. "Pipeline pauses - needs manual approval"
5. "I approve the deployment"
6. "Now it deploys to production safely"

### **Key Points**
- ✅ "All validation is automated"
- ✅ "Non-prod deploys automatically for fast testing"
- ✅ "Production has safety gate"
- ✅ "Complete audit trail"
- ✅ "No manual Terraform commands"

---

## 🆘 Troubleshooting

### **PR doesn't trigger CI**
- Check you're creating PR to `dev` or `master` branch
- Check files changed are in `environments/**` or `modules/**`

### **CD doesn't run after merge**
- Check you merged to `dev` or `master` (not feature branch)
- Check GitHub Actions tab for any errors

### **Can't find "Review deployments"**
- Go to Actions tab
- Click on the running workflow
- Button appears at top of the page

### **Approval button not showing**
- You need to set up environments first
- Settings → Environments → Create `prod` and `non-prod`
- Add required reviewers for `prod`

---

## 📞 Support

Questions? Check:
- [WORKFLOW.md](./WORKFLOW.md) - Detailed workflow documentation
- [GitHub Actions Logs](https://github.com/Dipendra-Raghav/Terraform-CICD/actions)
- Contact DevOps team

---

## ✅ Success Criteria

You'll know it's working when:

1. ✅ PR to dev triggers CI
2. ✅ Merge to dev auto-deploys to non-prod
3. ✅ PR to master triggers CI
4. ✅ Merge to master waits for approval
5. ✅ Approval triggers prod deployment
6. ✅ All artifacts are uploaded
7. ✅ PR comments show status

**You're all set! Start with Step 1 above.** 🚀
