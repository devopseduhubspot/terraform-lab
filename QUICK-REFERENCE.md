# 📋 Terraform Quick Reference - Beginner Cheat Sheet

## 🚀 Essential Commands (Copy/Paste Ready)

### Basic Terraform Workflow:
```bash
# 1. Initialize (download providers/modules)
terraform init

# 2. Preview changes (see what will happen)
terraform plan

# 3. Apply changes (create resources)
terraform apply
# Type: yes

# 4. Destroy everything (CRITICAL for cost control)
terraform destroy  
# Type: yes
```

### AWS CLI Commands:
```bash
# Check if AWS is configured
aws sts get-caller-identity

# Configure AWS (run once after installation)
aws configure
# Enter: Access Key, Secret Key, ap-south-1, json

# Update Kubernetes connection (Part 3 only)
aws eks update-kubeconfig --region ap-south-1 --name student-eks-cluster
```

### Kubernetes Commands (Part 3 only):
```bash
# Deploy application
kubectl apply -f k8s-deploy.yaml

# Check if pods are running
kubectl get pods

# Check application URL (wait for EXTERNAL-IP)
kubectl get service demo-service

# Scale application (try this!)
kubectl scale deployment demo-app --replicas=5

# Delete application (before terraform destroy)
kubectl delete -f k8s-deploy.yaml
```

## 📁 Navigation Commands (Windows)

```bash
# Go to main directory
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab

# Go to Part 1
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part1-terraform-basic

# Go to Part 2  
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part2-aws-basic

# Go to Part 3
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part3-eks-microservice

# Check current directory
pwd

# List files in directory
dir
```

## ⚡ Quick Learning Path

### Part 1 (10 minutes):
```bash
cd part1-terraform-basic
terraform init
terraform plan
terraform apply    # Type: yes
# Check: hello.txt file created
terraform destroy  # Type: yes
```

### Part 2 (15 minutes):
```bash
cd part2-aws-basic
terraform init
terraform plan
terraform apply    # Type: yes
# Check: AWS S3 console for bucket
terraform destroy  # Type: yes
```

### Part 3 (45 minutes):
```bash
cd part3-eks-microservice
terraform init
terraform plan
terraform apply    # Type: yes, wait 15-20 minutes
aws eks update-kubeconfig --region ap-south-1 --name student-eks-cluster
kubectl apply -f k8s-deploy.yaml
kubectl get service demo-service  # Wait for EXTERNAL-IP
# Visit: http://EXTERNAL-IP in browser
kubectl delete -f k8s-deploy.yaml
terraform destroy  # Type: yes, wait 10-15 minutes
```

## 🚨 Emergency Cost Control

If you see unexpected AWS charges:

```bash
# Emergency cleanup - run in ALL parts where you used terraform apply
terraform destroy

# Check what's running in AWS (if commands fail, use AWS console)
aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].[InstanceId,InstanceType]' --output table

aws elbv2 describe-load-balancers --query 'LoadBalancers[?State.Code==`active`].[LoadBalancerName,Type]' --output table

aws eks list-clusters

# Manual cleanup order in AWS console:
# 1. Load Balancers
# 2. EKS Clusters  
# 3. EC2 Instances
# 4. NAT Gateways
# 5. VPCs
```

## 🔍 Verification Commands

### Check if tools are installed:
```bash
terraform --version    # Should show: Terraform v1.x.x
aws --version          # Should show: aws-cli/2.x.x
kubectl version --client  # Should show: Client Version (Part 3 only)
```

### Check AWS connection:
```bash
aws sts get-caller-identity
# Should show: Account, Arn (with root), UserId
```

### Check costs (use AWS console):
1. Go to: https://console.aws.amazon.com/billing/
2. Click "Bills" 
3. Current month should show minimal charges
4. Set up billing alerts at $5, $10, $20

## 📊 Expected Costs (If Left Running)

| Part | Resources | Daily Cost | Safe Duration |
|------|-----------|------------|---------------|
| Part 1 | Local file only | $0 | Forever |
| Part 2 | S3 bucket (empty) | ~$0.01 | 1 day |
| Part 3 | EKS + nodes + networking | $4-6 | 1 hour max |

## 🎯 Success Indicators

### Part 1 Success:
- ✅ `hello.txt` file appears locally
- ✅ File disappears after `terraform destroy`
- ✅ No errors in commands

### Part 2 Success:
- ✅ Bucket appears in AWS S3 console
- ✅ Bucket disappears after `terraform destroy`
- ✅ AWS bill shows ~$0.00

### Part 3 Success:
- ✅ EKS cluster shows "Active" in AWS console
- ✅ `kubectl get pods` shows 2 running pods
- ✅ `kubectl get service` shows EXTERNAL-IP
- ✅ Browser shows Nginx welcome page at external IP
- ✅ Everything disappears after cleanup
- ✅ AWS bill returns to ~$0.00

## 🆘 When Things Go Wrong

### Most Common Issues:
1. **Forgot to run `terraform destroy`** → Go to AWS console, delete manually
2. **Commands not found** → Restart PowerShell, check installation  
3. **AWS access denied** → Run `aws configure` again
4. **Terraform state locked** → Wait or restart computer

### Quick Fixes:
```bash
# Restart terraform
rm -rf .terraform
terraform init

# Unlock terraform (if locked)
terraform force-unlock LOCK_ID_FROM_ERROR

# Reset AWS config
aws configure

# Check if any terraform processes running
tasklist | findstr terraform
```

## 🎓 Key Concepts to Remember

### Infrastructure as Code:
- 📝 Write code describing what you want
- 🤖 Terraform reads code and creates resources
- 🔄 Repeatable and version-controlled
- 🧹 Easy to destroy when done

### Real-World Value:
- 💰 DevOps engineers: $80k-150k salaries
- 🏢 Every company uses similar tools
- 📈 Cloud market growing 20%+ yearly
- 🚀 High demand for these skills

### Professional Skills Learned:
- ✅ Terraform (Infrastructure as Code)
- ✅ AWS (Cloud Platform)
- ✅ Kubernetes (Container Orchestration) 
- ✅ VPC (Cloud Networking)
- ✅ Cost Management
- ✅ Troubleshooting

**🌟 Congratulations! You now have valuable, marketable skills!**