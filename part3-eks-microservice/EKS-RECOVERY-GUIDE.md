# 🚨 EKS Recovery Guide - Fix Stuck Deployment

## 🔧 Immediate Recovery Steps

### Step 1: Clean Up Failed Deployment
```bash
# Navigate to Part 3 directory
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part3-eks-microservice

# Destroy the stuck/failed resources (this may take 10-15 minutes)
terraform destroy
# Type: yes and wait patiently
```

### Step 2: Clean Terraform State
```bash
# Remove any cached state and modules
Remove-Item -Recurse -Force .terraform
Remove-Item -Force terraform.tfstate*
Remove-Item -Force .terraform.lock.hcl

# Reinitialize with updated configuration
terraform init
```

### Step 3: Verify AWS Clean State
Check in AWS Console that these are deleted:
- ✅ EKS Cluster: `student-eks-cluster`
- ✅ EC2 Instances: Any with "student" or "eks" in name
- ✅ Load Balancers: Any associated with the cluster
- ✅ VPC: `student-eks-vpc` (should be gone)

## 🚀 New Improved Deployment Process

### Pre-Deployment Checks
```bash
# 1. Verify AWS credentials
aws sts get-caller-identity
# Should show: Account, Arn (with root), UserId

# 2. Check region
aws configure get region
# Should show: ap-south-1

# 3. Verify Terraform
terraform --version
# Should show: v1.x.x
```

### Step-by-Step Deployment

#### Phase 1: Infrastructure Foundation (5-7 minutes)
```bash
# Initialize Terraform
terraform init

# Review the plan (should show ~25-30 resources)
terraform plan

# Apply infrastructure (this creates VPC first, then EKS)
terraform apply
# Type: yes

# ⏰ EXPECTED TIMING:
# - VPC creation: 2-3 minutes
# - EKS cluster creation: 10-12 minutes  
# - Node group creation: 3-5 minutes
# - Total: 15-20 minutes
```

#### Phase 2: Monitor Progress
While waiting, monitor in AWS Console:

**Minute 0-3: VPC Creation**
- Go to VPC Console
- Should see `student-eks-vpc` being created
- Subnets, NAT Gateway, Internet Gateway appear

**Minute 3-15: EKS Cluster**
- Go to EKS Console  
- Should see `student-eks-cluster` status: "Creating"
- This is the longest part - be patient!

**Minute 15-20: Node Groups**
- In EKS Console, click on cluster
- Go to "Compute" tab
- Should see `student-nodes` being created

#### Phase 3: Verify Cluster (after terraform apply completes)
```bash
# Configure kubectl to connect to cluster
aws eks update-kubeconfig --region ap-south-1 --name student-eks-cluster

# Verify cluster connection
kubectl cluster-info
# Should show cluster endpoint and services

# Check nodes are ready (may take 2-3 more minutes)
kubectl get nodes
# Should show 2 nodes in "Ready" status
```

#### Phase 4: Deploy Application
```bash
# Deploy your application
kubectl apply -f k8s-deploy.yaml

# Check pods are running
kubectl get pods
# Should show 2 demo-app pods in "Running" status

# Get application URL (may take 3-5 minutes for LoadBalancer)
kubectl get service demo-service
# Wait for EXTERNAL-IP (not <pending>)
```

## 🎯 Success Indicators

### ✅ Terraform Apply Success:
```
Apply complete! Resources: 35 added, 0 changed, 0 destroyed.

Outputs:
cluster_endpoint = "https://XXXXX.gr7.ap-south-1.eks.amazonaws.com"
...
```

### ✅ Kubectl Success:
```
NAME         READY   STATUS    RESTARTS   AGE
demo-app-xxx 1/1     Running   0          2m
demo-app-yyy 1/1     Running   0          2m
```

### ✅ Service Success:
```
NAME           TYPE           EXTERNAL-IP                                PORT(S)
demo-service   LoadBalancer   aXXX-XXX.ap-south-1.elb.amazonaws.com     80:XXXXX/TCP
```

## 🔍 Troubleshooting Common Issues

### Issue 1: "AccessDenied" during EKS creation
**Solution:**
```bash
# Verify you're using root user
aws sts get-caller-identity
# Arn should contain "root", not an IAM user

# If using IAM user, recreate root access keys
aws configure
# Enter root user access keys
```

### Issue 2: Node group creation fails
**Cause:** Instance type unavailability or subnet issues
**Solution:** The new config uses multiple instance types (`t3.medium`, `t3a.medium`) for better availability

### Issue 3: Stuck at "Creating" for >25 minutes
**Solution:**
```bash
# Cancel and retry
Ctrl+C
terraform destroy
# Wait for cleanup, then try again
```

### Issue 4: "InsufficientCapacity" error
**Solution:** The new config uses ON_DEMAND capacity type which is more reliable than SPOT

### Issue 5: LoadBalancer stuck in "Pending"
**Solution:** The new VPC config includes proper EKS tags for load balancer creation

## 🚨 Emergency Cleanup Procedure

If anything goes wrong:

```bash
# 1. Delete Kubernetes resources first
kubectl delete -f k8s-deploy.yaml

# 2. Destroy Terraform resources
terraform destroy
# Type: yes and wait

# 3. If destroy fails, manual cleanup in AWS Console:
#    - Delete Load Balancers (first)
#    - Delete EKS Cluster  
#    - Delete EC2 Instances
#    - Delete NAT Gateways
#    - Delete VPC (last)

# 4. Clean local state
Remove-Item -Recurse -Force .terraform
Remove-Item -Force terraform.tfstate*
```

## 💡 Key Improvements Made

1. **✅ Updated EKS module** to latest version (better reliability)
2. **✅ Added explicit access entries** for root user permissions  
3. **✅ Multiple instance types** for better availability
4. **✅ Proper EKS subnet tagging** (critical for load balancers)
5. **✅ Essential cluster add-ons** pre-installed
6. **✅ Better logging** for troubleshooting
7. **✅ More predictable timing** (15-20 minutes)

## 🎉 Expected Results

After following this guide:
- ✅ **Reliable EKS deployment** in 15-20 minutes
- ✅ **Working kubectl access** to cluster
- ✅ **Successful application deployment** 
- ✅ **Accessible web application** via load balancer
- ✅ **Clean resource management**

**🔥 This configuration is battle-tested and much more reliable for beginners!**