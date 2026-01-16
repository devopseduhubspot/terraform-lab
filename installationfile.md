# Connecting Terraform to AWS (Root User – Training Only)

## ⚠️ Important Teaching Note

> **Warning:** Using root user for Terraform is **not recommended** in real projects. It is only for training/demo.  
> In production, always use an IAM user or role with limited permissions.

But since you want to teach, here are the exact root-user steps.

## 🔐 Connecting Terraform with AWS using Root User

### Step 1: Login as Root User

1. Go to: https://aws.amazon.com/console/
2. Click **Sign in as root user**
3. Enter your root email and password

### Step 2: Create Access Keys for Root User

1. Open **IAM**
2. Click your account name (top right)
3. Click **Security Credentials**
4. Scroll to **Access keys**
5. Click **Create access key**
6. Choose:
   - **Use case:** Command Line Interface (CLI)
7. Download the credentials:
   - Access key ID
   - Secret access key

> ⚠️ **Save them safely. Secret key is shown only once.**

### Step 3: Install AWS CLI

**Windows:**
```
https://awscli.amazonaws.com/AWSCLIV2.msi
```

**Verify:**
```bash
aws --version
```

### Step 4: Configure AWS CLI

**Run:**
```bash
aws configure
```

**Enter:**
```
AWS Access Key ID:     <your-access-key>
AWS Secret Access Key: <your-secret-key>
Default region name:   ap-south-1
Default output format: json
```

This stores credentials in:
```
C:\Users\<username>\.aws\credentials
```

### Step 5: Verify AWS Access

```bash
aws sts get-caller-identity
```

**You should see:**
```json
{
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:root",
  "UserId": "123456789012"
}
```

This confirms Terraform will use the root AWS account.

### Step 6: Terraform Automatically Uses AWS CLI Credentials

No extra config is required.

**Your Terraform AWS provider:**
```hcl
provider "aws" {
  region = "ap-south-1"
}
```

Terraform will automatically read credentials from:
```
~/.aws/credentials
```

## 🧨 Root User Safety Rule (Teach Students)

**After class:**

1. **Destroy infrastructure:**
   ```bash
   terraform destroy
   ```

2. **Delete Root Access Keys:**
   - Go to **IAM → Security Credentials**
   - Delete the access keys

**This prevents:**
- Accidental billing
- Security breaches

## 💼 Optional (Professional Way – Mention to Students)

**Instead of root user:**

1. Create **IAM User**
2. Attach policy: `AdministratorAccess`
3. Use its access keys with `aws configure`

> This is the **real-world standard**.

---

## 🎯 Training Package Complete

This completes your repo as a full end-to-end Terraform training package:

- ✅ Code
- ✅ AWS connection
- ✅ EKS setup
- ✅ Microservice deployment
- ✅ Cleanup
- ✅ Billing safety

**Perfect for classroom and corporate training.**