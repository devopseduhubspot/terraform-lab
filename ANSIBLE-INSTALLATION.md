# 🎭 Ansible Installation Guide for Windows

## 🎯 Quick Setup for Part 4

### Method 1: WSL (Recommended)

#### Step 1: Enable WSL
```powershell
# Run as Administrator in PowerShell
wsl --install
# Restart computer when prompted
```

#### Step 2: Install Ubuntu
```powershell
# Open Microsoft Store
# Search "Ubuntu 22.04"  
# Click Install
```

#### Step 3: Install Ansible in WSL
```bash
# Open Ubuntu terminal
sudo apt update
sudo apt install python3 python3-pip -y
pip3 install ansible boto3 botocore

# Verify installation
ansible --version
```

### Method 2: Windows Native (Alternative)

#### Step 1: Install Python
1. Go to https://python.org/downloads/
2. Download Python 3.9+
3. **IMPORTANT:** Check "Add to PATH" during installation

#### Step 2: Install Ansible
```powershell
# In PowerShell/Command Prompt
pip install ansible boto3 botocore

# Verify installation
ansible --version
```

### Method 3: Using Chocolatey
```powershell
# Install Chocolatey first (if not installed)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Python and Ansible
choco install python3
pip install ansible boto3 botocore
```

## ✅ Verification

Test your installation:
```bash
# Check versions
ansible --version
python3 --version
pip3 --version

# Test basic functionality
ansible localhost -m ping
```

## 🎯 Ready for Part 4!

Once Ansible is installed:
1. Navigate to [Part 4A](part4-ansible-config/part4a-ansible-basics/)
2. Follow the step-by-step guide
3. Enjoy automating server configurations!

## 🆘 Troubleshooting

### Issue: "ansible: command not found"
**Solution:** Restart terminal/PowerShell after installation

### Issue: "Permission denied"
**Solution:** Use `pip3 install --user ansible` instead

### Issue: "Python not found"
**Solution:** Ensure Python is added to PATH during installation

## 💡 Why WSL is Recommended

- ✅ **Native Linux environment** for Ansible
- ✅ **Better compatibility** with SSH and networking
- ✅ **Easier package management**
- ✅ **More reliable** for DevOps tools
- ✅ **Industry standard** approach

**🎉 You're ready to become a configuration management expert!**