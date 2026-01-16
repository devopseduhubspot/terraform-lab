
# 📚 Part 1: Your First Terraform Code (Super Easy!)

## 🎯 What We're Doing

**Goal:** Create a simple text file using Terraform code  
**Why:** Learn Terraform basics without any cloud costs  
**Time:** 10 minutes  
**Risk:** ZERO (completely safe, local only)

## 🤔 Real-World Analogy

Think of this like teaching a robot to write a letter:
- 📝 You write **instructions** (Terraform code)
- 🤖 The robot **follows instructions** (Terraform runs)
- 📄 A **letter appears** (file gets created)

## 🔍 Understanding the Code

Let's look at our [main.tf](main.tf) file:

```hcl
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "hello" {
  filename = "hello.txt"
  content  = "Hello Students, this is your first Terraform code!"
}
```

### 🎓 Code Explanation (Non-Technical):

| Line | What It Does | Real-World Analogy |
|------|-------------|-------------------|
| `terraform { ... }` | "I need specific tools" | Like saying "I need a pen to write" |
| `required_providers` | "Get me the 'local' tool" | Like getting a specific type of pen |
| `resource "local_file"` | "Create a file" | Like saying "write on paper" |
| `filename = "hello.txt"` | "Name the file hello.txt" | Like writing the letter title |
| `content = "..."` | "Put this text inside" | Like writing the letter content |

## 🚀 Step-by-Step Instructions

### Step 1: Open Terminal
1. Press `Windows Key + R`
2. Type `cmd` and press Enter
3. Navigate to this folder:
   ```cmd
   cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part1-terraform-basic
   ```

### Step 2: Initialize Terraform
```bash
terraform init
```
**What this does:** Downloads the "local" tool we need

**Expected output:**
```
Initializing the backend...
Initializing provider plugins...
- Installing hashicorp/local...
✅ Terraform has been successfully initialized!
```

### Step 3: Plan (Preview) Changes
```bash
terraform plan
```
**What this does:** Shows you what will happen (like a preview)

**Expected output:**
```
+ resource "local_file" "hello" {
    + content  = "Hello Students, this is your first Terraform code!"
    + filename = "hello.txt"
  }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### Step 4: Apply Changes (Do It!)
```bash
terraform apply
```
**What this does:** Actually creates the file

1. Type `yes` when asked
2. Press Enter

**Expected output:**
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

### Step 5: Check the Magic! 🎉
1. Look in your current folder
2. You'll see a new file: `hello.txt`
3. Open it - it contains your message!

## 🎓 What Just Happened?

1. 📝 You wrote **code** that describes what you want
2. 🤖 Terraform **read** your code
3. 🏗️ Terraform **created** exactly what you described
4. ✅ A file appeared **automatically**!

This is the **core concept** of "Infrastructure as Code"!

## 🧪 Try This Experiment

Want to see more magic? Let's modify the file:

1. Open [main.tf](main.tf) in notepad
2. Change the content to:
   ```hcl
   content = "I just learned Terraform! This is amazing!"
   ```
3. Save the file
4. Run: `terraform apply`
5. Type `yes`
6. Check `hello.txt` - the content changed!

**🎯 Key Insight:** Terraform ensures your files match your code!

## 🧹 Part 1 Cleanup (ALWAYS DO THIS!)

```bash
terraform destroy
```
Type `yes` when asked.

**What this does:** Deletes the `hello.txt` file

**Why cleanup?** Good practice for when we use AWS (which costs money)

## 🎉 Congratulations!

You just:
- ✅ Wrote your first Infrastructure as Code
- ✅ Saw automation in action
- ✅ Learned the core Terraform workflow
- ✅ Practiced safe cleanup habits

## 🚀 Next Steps

**Ready for the cloud?** Move to [Part 2](../part2-aws-basic/) where we create real AWS resources!

**Feeling confident?** You should! You just learned what companies pay DevOps engineers $100k+ to do! 💰
