# 🎭 Part 4A: Your First Ansible Automation

## 🎯 What We're Building

**Goal:** Create EC2 servers and use Ansible to configure them automatically  
**Why:** Learn the foundation of server automation  
**Time:** 30 minutes  
**Cost:** ~$0.50 (2 small servers for 1 hour)

## 🤔 What You'll Learn

Think of this like **teaching a robot to set up computers:**
- 🏗️ **Terraform** builds the computers (EC2 instances)
- 🎭 **Ansible** configures the computers (installs software, changes settings)
- 🤖 **You write instructions** once, robot does it on all computers
- 🔄 **Repeatable** - works the same way every time

## 🚀 Step-by-Step Guide

### Step 1: Install Ansible (5 minutes)

#### For Windows (using WSL - recommended):
```bash
# Install Python and pip
sudo apt update
sudo apt install python3 python3-pip -y

# Install Ansible
pip3 install ansible boto3 botocore

# Verify installation
ansible --version
```

#### Alternative - Windows Native (if WSL not available):
```powershell
# Install Python first from https://python.org
# Then install Ansible
pip install ansible boto3 botocore
```

### Step 2: Create EC2 Infrastructure (5 minutes)

**Review the Terraform code:** [main.tf](main.tf)

```bash
# Navigate to part 4a directory
cd c:\Users\KUMRAK\gittraining\terraform-learning\terraform-lab\part4-ansible-config\part4a-ansible-basics

# Initialize and deploy
terraform init
terraform plan
terraform apply
# Type: yes
```

**⏰ Expected time:** 3-4 minutes to create 2 servers

### Step 3: Configure Ansible Connection (5 minutes)

**Check the Ansible configuration:** [ansible.cfg](ansible.cfg)

**Review the inventory:** [inventory.yml](inventory.yml) 

**Test connection to servers:**
```bash
# Test if Ansible can reach the servers
ansible all -m ping

# Expected output:
# web-server-1 | SUCCESS => { "ping": "pong" }
# web-server-2 | SUCCESS => { "ping": "pong" }
```

### Step 4: Run Your First Playbook (10 minutes)

**Review the playbook:** [setup-servers.yml](setup-servers.yml)

```bash
# Run the basic server setup playbook
ansible-playbook setup-servers.yml

# This will:
# - Update all packages
# - Install essential software
# - Create a user account
# - Set up basic security
```

### Step 5: Verify Results (5 minutes)

```bash
# Check what Ansible installed
ansible all -m shell -a "htop --version"
ansible all -m shell -a "git --version" 
ansible all -m shell -a "curl --version"

# Check server info
ansible all -m setup -a "filter=ansible_distribution*"
```

**🎉 Success!** You just automated server configuration across multiple machines!

## 🎓 Understanding What Happened

### Real-World Comparison:
| Manual Way (Old) | Ansible Way (Modern) |
|------------------|----------------------|
| 🖱️ SSH to each server individually | 📡 Connect to all servers at once |
| ⌨️ Type same commands 100 times | ✍️ Write instructions once |  
| 😰 Errors and inconsistencies | 🎯 Perfect consistency |
| ⏰ Hours of repetitive work | ⚡ Minutes of automated work |

### What Each File Does:

#### [main.tf](main.tf) - Infrastructure
```hcl
# Creates 2 EC2 instances
# Sets up security groups  
# Generates SSH key pair
# Outputs server IPs for Ansible
```

#### [ansible.cfg](ansible.cfg) - Ansible Settings
```ini
# Tells Ansible how to connect
# Sets SSH options
# Configures logging
```

#### [inventory.yml](inventory.yml) - Server List
```yaml
# Lists all servers to manage
# Groups servers by role
# Sets connection details
```

#### [setup-servers.yml](setup-servers.yml) - Automation Instructions
```yaml
# Step-by-step server setup
# Install software packages
# Configure security settings
# Create user accounts
```

## 🧪 Try These Experiments

### Experiment 1: Add More Software
Edit [setup-servers.yml](setup-servers.yml) and add:
```yaml
- name: Install additional tools
  package:
    name:
      - vim
      - tree
      - wget
    state: present
```

Then run: `ansible-playbook setup-servers.yml`

### Experiment 2: Create Files on Servers
Add to your playbook:
```yaml
- name: Create a welcome file
  copy:
    content: "Welcome to {{ inventory_hostname }}!\nManaged by Ansible\n"
    dest: /home/ubuntu/welcome.txt
```

### Experiment 3: Check Server Status
```bash
# Get system information from all servers
ansible all -m setup

# Check disk space
ansible all -m shell -a "df -h"

# Check running processes  
ansible all -m shell -a "ps aux | head -10"
```

## 🎯 Key Concepts Learned

### 1. **Idempotency** 
- ✅ Safe to run playbooks multiple times
- ✅ Ansible only makes necessary changes
- ✅ No duplicate or conflicting configurations

### 2. **Inventory Management**
- ✅ Central list of all servers
- ✅ Group servers by role (web, database, etc.)
- ✅ Set variables per group or server

### 3. **Playbooks**
- ✅ Step-by-step automation instructions
- ✅ Written in YAML (human-readable)
- ✅ Reusable across environments

### 4. **Modules**
- ✅ Pre-built functions (package, copy, service, etc.)
- ✅ Handle different operating systems
- ✅ Provide consistent results

## 💼 Real-World Applications

### Companies Use This For:
- 🏢 **Netflix:** Configure streaming servers worldwide
- 🚗 **Uber:** Set up ride-matching infrastructure  
- 🏦 **Banks:** Ensure security compliance
- 🛒 **E-commerce:** Prepare for traffic spikes
- 🎮 **Gaming:** Deploy game servers globally

### Career Value:
- 💰 **Ansible skills** are in high demand
- 📈 **Automation expertise** commands premium salaries
- 🚀 **DevOps career path** often starts with configuration management
- 🎯 **Complements Terraform** knowledge perfectly

## 🧹 Cleanup (CRITICAL!)

```bash
# Always destroy resources to avoid charges
terraform destroy
# Type: yes

# Verify in AWS Console:
# - EC2 instances terminated
# - Security groups deleted  
# - Key pairs removed
```

## 🎉 Congratulations!

You just learned:
- ✅ **Infrastructure + Configuration** automation
- ✅ **Multi-server management** with Ansible
- ✅ **Idempotent automation** concepts
- ✅ **Real DevOps workflow** (Terraform → Ansible)

## 🚀 Next Steps

**Ready for more?**

### Option 1: **Continue Learning**
- 🌐 [Part 4B: Web Server Setup](../part4b-web-servers/) - Deploy websites with Ansible

### Option 2: **Experiment More**
- 📝 Modify the playbook to install different software
- 🔧 Add more server configurations
- 🎯 Try different Ansible modules

### Option 3: **Career Development**  
- 📚 Study Ansible documentation
- 🎓 Consider Ansible certification  
- 💼 Look for DevOps job opportunities

**🌟 You now have valuable skills that companies pay $75k-130k for!**