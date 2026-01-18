# 🔧 Ansible Troubleshooting Guide for Beginners

## 🚨 Common Ansible Issues and Solutions

### 🔐 SSH Connection Issues

#### Problem: "UNREACHABLE" when running ansible ping
```
web-server-1 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh",
    "unreachable": true
}
```

**Solutions:**
1. **Check server is running:**
   ```bash
   # In AWS Console, verify EC2 instances are "running"
   # Wait 2-3 minutes after terraform apply
   ```

2. **Test SSH manually:**
   ```bash
   ssh -i ansible-key.pem ubuntu@SERVER_IP
   # If this fails, Ansible will fail too
   ```

3. **Fix SSH key permissions:**
   ```bash
   chmod 600 ansible-key.pem
   ```

4. **Check security groups:**
   - AWS Console → EC2 → Security Groups
   - Ensure port 22 (SSH) is open

#### Problem: "Host key verification failed"
**Solution:**
```bash
# Add to ansible.cfg
[defaults]
host_key_checking = False

# Or run once:
export ANSIBLE_HOST_KEY_CHECKING=False
```

### 📦 Package Installation Issues

#### Problem: "Package not found" or "apt lock"
```
TASK [Install essential packages] ****
failed: [web-server-1] => {"msg": "Could not lock /var/lib/dpkg/lock-frontend"}
```

**Solutions:**
1. **Wait for cloud-init:**
   ```bash
   # Check if cloud-init is still running
   ansible all -m shell -a "cloud-init status"
   # Wait until "done" status
   ```

2. **Update package cache:**
   ```bash
   ansible all -m apt -a "update_cache=yes" --become
   ```

3. **Clear apt locks manually:**
   ```bash
   ansible all -m shell -a "sudo killall apt-get" --become
   ansible all -m shell -a "sudo rm /var/lib/dpkg/lock*" --become
   ```

### 🎭 Ansible Configuration Issues

#### Problem: "ansible: command not found"
**Solutions:**
```bash
# Check if Ansible is installed
which ansible

# Install Ansible
pip3 install ansible

# Add to PATH (if needed)
export PATH=$PATH:~/.local/bin
```

#### Problem: "No inventory was parsed from the inventory file"
**Solutions:**
1. **Check inventory file exists:**
   ```bash
   ls -la inventory.yml
   ```

2. **Verify inventory syntax:**
   ```bash
   ansible-inventory --list
   ```

3. **Test inventory:**
   ```bash
   ansible all --list-hosts
   ```

### 💻 Server Access Issues

#### Problem: "sudo: password required"
**Solution:** Add to playbook:
```yaml
- hosts: all
  become: yes
  become_method: sudo
  become_user: root
```

#### Problem: "Permission denied (publickey)"
**Solutions:**
1. **Check SSH agent:**
   ```bash
   ssh-add ansible-key.pem
   ```

2. **Use explicit key:**
   ```bash
   ansible all -m ping --private-key=ansible-key.pem
   ```

### 🏗️ Terraform Integration Issues

#### Problem: "Inventory file not created"
**Solutions:**
1. **Check Terraform outputs:**
   ```bash
   terraform output
   ```

2. **Manually recreate inventory:**
   ```bash
   terraform apply  # This regenerates files
   ```

3. **Check template file:**
   ```bash
   cat inventory.tpl  # Should exist
   ```

### 🎯 Playbook Execution Issues

#### Problem: "Playbook syntax error"
```
ERROR! Syntax Error while loading YAML.
```

**Solutions:**
1. **Check YAML syntax:**
   ```bash
   ansible-playbook setup-servers.yml --syntax-check
   ```

2. **Validate indentation:**
   - Use spaces, not tabs
   - Consistent 2-space indentation
   - Use YAML validator online

3. **Check for common mistakes:**
   ```yaml
   # Wrong:
   - name: task name
   apt:
     name: package
   
   # Correct:
   - name: task name
     apt:
       name: package
   ```

#### Problem: "Module not found"
**Solution:**
```bash
# Update Ansible
pip3 install --upgrade ansible

# Check available modules
ansible-doc -l | grep module_name
```

## 🌐 Network and AWS Issues

### Problem: "Timeout connecting to servers"
**Solutions:**
1. **Check AWS region:**
   ```bash
   aws configure get region  # Should be ap-south-1
   ```

2. **Verify NAT Gateway (if using private subnets):**
   - AWS Console → VPC → NAT Gateways
   - Should be "Available"

3. **Check route tables:**
   - Private subnets should route to NAT Gateway
   - Public subnets should route to Internet Gateway

### Problem: "EC2 instances not accessible"
**Solutions:**
1. **Check instance state:**
   ```bash
   aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name,PublicIpAddress]' --output table
   ```

2. **Verify security groups:**
   ```bash
   aws ec2 describe-security-groups --group-names ansible-learning-sg
   ```

## 🔍 Debugging Tools and Commands

### General Debugging:
```bash
# Verbose output (levels: -v, -vv, -vvv, -vvvv)
ansible-playbook setup-servers.yml -vvv

# Check connectivity
ansible all -m ping

# Get system facts
ansible all -m setup

# Test specific tasks
ansible-playbook setup-servers.yml --tags packages
```

### Server Information:
```bash
# Check server details
ansible all -m shell -a "uname -a"
ansible all -m shell -a "free -h"
ansible all -m shell -a "df -h"

# Check network connectivity
ansible all -m shell -a "ping -c 3 google.com"
```

### Log Analysis:
```bash
# Ansible logs (if configured)
tail -f /var/log/ansible.log

# SSH debug
ssh -vvv -i ansible-key.pem ubuntu@SERVER_IP

# System logs on target servers
ansible all -m shell -a "tail -20 /var/log/syslog" --become
```

## 🆘 Emergency Recovery Procedures

### If Servers Become Unreachable:
1. **Destroy and recreate:**
   ```bash
   terraform destroy
   terraform apply
   # Wait 3-5 minutes for full boot
   ```

2. **Check AWS Console:**
   - EC2 instances should be "running"
   - Security groups properly configured
   - Key pairs exist

### If Ansible Configuration Corrupted:
```bash
# Clean up and regenerate
rm -f ansible.cfg inventory.yml ansible-key.pem
terraform apply  # Regenerates files

# Test basic connection
ansible all -m ping
```

### If Playbook Fails Partially:
```bash
# Run specific tags only
ansible-playbook setup-servers.yml --tags setup

# Skip problematic tasks
ansible-playbook setup-servers.yml --skip-tags security

# Run on specific hosts
ansible-playbook setup-servers.yml --limit web-server-1
```

## 💡 Best Practices to Avoid Issues

### Before Running Playbooks:
- [ ] ✅ Verify all servers are accessible: `ansible all -m ping`
- [ ] ✅ Check syntax: `ansible-playbook playbook.yml --syntax-check`
- [ ] ✅ Run with dry-run first: `ansible-playbook playbook.yml --check`

### During Development:
- [ ] ✅ Use tags for modular execution
- [ ] ✅ Test on single server first: `--limit web-server-1`
- [ ] ✅ Use verbose mode for debugging: `-vvv`

### Cost Control:
- [ ] ✅ Set timers for AWS resources
- [ ] ✅ Always run `terraform destroy` after learning
- [ ] ✅ Monitor AWS billing dashboard

## 🎓 Learning from Errors

**Remember:** 
- 🔥 **Errors are learning opportunities** - every DevOps engineer faces these
- 📚 **Read error messages carefully** - they usually tell you what's wrong
- 🛠️ **Practice troubleshooting** - it's 50% of the job
- 💪 **Persistence is key** - complex systems take time to master

**Professional tip:** Senior Ansible engineers spend significant time troubleshooting. These skills are valuable and transferable! 🌟