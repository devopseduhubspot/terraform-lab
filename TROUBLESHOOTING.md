# 🔧 Troubleshooting Guide for Beginners

## 🚨 Common Issues and Solutions

### 💰 AWS Billing Issues

#### Problem: "I'm getting charged money!"
**Solution:**
1. **Immediate action:** Run `terraform destroy` in the part causing charges
2. **Check AWS console:** Verify resources are deleted
3. **Contact AWS support:** If charges seem wrong

#### Problem: "Destroy failed, resources still exist"
**Solution:**
1. **Manual cleanup:** Go to AWS console and delete resources manually
2. **Common order:** Delete Load Balancers → EKS Cluster → VPC
3. **Then retry:** `terraform destroy`

### 🔐 AWS Authentication Issues

#### Problem: "AccessDenied" or "Unable to locate credentials"
**Solutions:**
1. **Check AWS CLI:** Run `aws sts get-caller-identity`
2. **Reconfigure:** Run `aws configure` and re-enter credentials
3. **Check region:** Ensure you're using `ap-south-1`

#### Problem: "Root access key not working"
**Solutions:**
1. **Verify root login:** Use root email/password, not IAM user
2. **Recreate keys:** Delete old access keys, create new ones
3. **Check permissions:** Root user has all permissions by default

### 🏗️ Terraform Issues

#### Problem: "terraform: command not found"
**Solutions:**
1. **Restart terminal:** Close and reopen PowerShell
2. **Check PATH:** Terraform should be in system PATH
3. **Reinstall:** Follow [installation guide](installation.md)

#### Problem: "Error locking state file"
**Solutions:**
1. **Wait:** Another terraform command might be running
2. **Kill process:** Check Task Manager for terraform.exe
3. **Force unlock:** `terraform force-unlock LOCK_ID`

#### Problem: "Resource already exists"
**Solutions:**
1. **Import existing:** `terraform import aws_s3_bucket.demo_bucket bucket-name`
2. **Or delete manually:** Remove from AWS console first
3. **Then retry:** `terraform apply`

### 🏢 Part 3 (EKS) Specific Issues

#### Problem: "EKS cluster creation takes forever"
**Normal behavior:** EKS takes 15-20 minutes to create
**Solution:** Be patient, set a timer, don't cancel

#### Problem: "kubectl: command not found"
**Solutions:**
1. **Install kubectl:** Download from AWS documentation
2. **Add to PATH:** Ensure kubectl.exe is in system PATH
3. **Update kubeconfig:** `aws eks update-kubeconfig --region ap-south-1 --name student-eks-cluster`

#### Problem: "LoadBalancer stuck in Pending"
**Solutions:**
1. **Wait:** AWS Load Balancer takes 2-5 minutes to provision
2. **Check security groups:** EKS should create them automatically
3. **Verify subnets:** Ensure public subnets have internet gateway

#### Problem: "Can't access application URL"
**Solutions:**
1. **Wait for LoadBalancer:** Check `kubectl get service` until EXTERNAL-IP appears
2. **Use HTTP not HTTPS:** `http://your-ip` not `https://your-ip`
3. **Check security groups:** Port 80 should be open

### 💻 Windows-Specific Issues

#### Problem: "PowerShell execution policy"
**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Problem: "Path with spaces causing issues"
**Solution:** Use quotes around paths:
```bash
cd "c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab"
```

#### Problem: "Line ending issues in files"
**Solution:** Use notepad++ or VS Code, set line endings to LF

### 📊 AWS Console Verification

#### After Part 1:
- **Check:** Local directory for `hello.txt` file
- **Cleanup:** File should disappear after `terraform destroy`

#### After Part 2:
- **Check:** AWS S3 console for your bucket
- **Cleanup:** Bucket should disappear after `terraform destroy`

#### After Part 3:
- **Check:**
  - EC2 console: Worker nodes running
  - EKS console: Cluster active
  - VPC console: New VPC with subnets
  - Load Balancers: External load balancer
- **Cleanup:** All should disappear after proper cleanup

## 🆘 Emergency Procedures

### If You're Getting Billed Too Much:

1. **STOP EVERYTHING:** Don't create new resources
2. **Run destroy:** In all part directories where you ran `apply`
3. **Manual cleanup:** Delete everything in AWS console:
   - Load Balancers (first)
   - EKS Clusters
   - EC2 instances
   - NAT Gateways
   - VPCs (last)
4. **Contact AWS:** If bill seems wrong
5. **Set billing alerts:** $5, $10, $20 limits

### If Nothing Works:

1. **Start fresh:** Delete `.terraform` folders and run `terraform init` again
2. **New terminal:** Close and open new PowerShell
3. **Reboot computer:** Sometimes Windows needs a restart
4. **Ask for help:** Take screenshots of error messages

## 📞 Getting Help

### Where to Ask:
1. **AWS Support:** For billing issues
2. **Stack Overflow:** For technical issues
3. **Terraform Documentation:** https://registry.terraform.io/
4. **AWS Documentation:** https://docs.aws.amazon.com/

### What Information to Include:
1. **Error message:** Copy/paste exactly
2. **Which part:** Part 1, 2, or 3
3. **What you were trying:** `terraform apply`, etc.
4. **Your OS:** Windows version
5. **Screenshots:** Of error messages

## 💡 Prevention Tips

### Before Starting Each Part:
- [ ] ✅ Read the README completely
- [ ] ✅ Set a timer for cleanup
- [ ] ✅ Check AWS billing dashboard
- [ ] ✅ Have fresh terminal/PowerShell

### During Each Part:
- [ ] ✅ Copy/paste commands exactly
- [ ] ✅ Wait for completion before next step
- [ ] ✅ Don't modify code unless instructed
- [ ] ✅ Take notes of what you learn

### After Each Part:
- [ ] ✅ Always run cleanup (`terraform destroy`)
- [ ] ✅ Verify resources deleted in AWS console
- [ ] ✅ Check billing dashboard
- [ ] ✅ Note what you learned

## 🎓 Learning from Errors

**Remember:** Every DevOps engineer deals with these issues daily!

- 🔥 **Breaking things is normal** - that's how you learn
- 📚 **Error messages teach you** - read them carefully  
- 🛠️ **Troubleshooting is a skill** - you're developing it
- 💪 **Persistence pays off** - keep trying!

**Professional tip:** Senior engineers spend 50% of their time troubleshooting. You're building real-world skills! 🌟