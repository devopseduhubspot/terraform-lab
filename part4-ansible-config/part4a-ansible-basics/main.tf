# 🏗️ Part 4A: EC2 Infrastructure for Ansible Learning
# This creates 2 simple EC2 instances that Ansible will configure

# AWS Provider
provider "aws" {
  region = "ap-south-1"  # Mumbai region (cost-effective)
}

# Data source for latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu official)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Generate SSH key pair for Ansible
resource "tls_private_key" "ansible_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ansible_keypair" {
  key_name   = "ansible-learning-key"
  public_key = tls_private_key.ansible_key.public_key_openssh
}

# Save private key to local file for Ansible
resource "local_file" "private_key" {
  content         = tls_private_key.ansible_key.private_key_pem
  filename        = "ansible-key.pem"
  file_permission = "0600"
}

# Security group for web servers
resource "aws_security_group" "ansible_sg" {
  name        = "ansible-learning-sg"
  description = "Security group for Ansible learning servers"

  # SSH access (for Ansible)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access for Ansible"
  }

  # HTTP access (for web servers in later parts)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # HTTPS access (for web servers in later parts)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access"
  }

  # Outbound traffic (for package installation)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name        = "ansible-learning-sg"
    Environment = "learning"
    ManagedBy   = "terraform"
  }
}

# EC2 Instance 1 - Web Server
resource "aws_instance" "web_server_1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"  # Free tier eligible, cheap
  key_name               = aws_key_pair.ansible_keypair.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  # User data to prepare for Ansible (minimal setup)
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              # Ansible uses Python, so ensure it's available
              EOF

  tags = {
    Name        = "web-server-1"
    Role        = "webserver"
    Environment = "learning"
    ManagedBy   = "terraform"
  }
}

# EC2 Instance 2 - Web Server
resource "aws_instance" "web_server_2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"  # Free tier eligible, cheap
  key_name               = aws_key_pair.ansible_keypair.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  # User data to prepare for Ansible (minimal setup)
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              # Ansible uses Python, so ensure it's available
              EOF

  tags = {
    Name        = "web-server-2"
    Role        = "webserver"
    Environment = "learning"
    ManagedBy   = "terraform"
  }
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    web_server_1_ip = aws_instance.web_server_1.public_ip
    web_server_2_ip = aws_instance.web_server_2.public_ip
  })
  filename = "inventory.yml"
}

# Generate Ansible configuration file
resource "local_file" "ansible_cfg" {
  content = <<-EOF
[defaults]
host_key_checking = False
inventory = inventory.yml
private_key_file = ansible-key.pem
remote_user = ubuntu
timeout = 30

[ssh_connection]
ssh_args = -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
pipelining = True
EOF
  filename = "ansible.cfg"
}

# Outputs for verification
output "web_server_1_ip" {
  description = "Public IP of Web Server 1"
  value       = aws_instance.web_server_1.public_ip
}

output "web_server_2_ip" {
  description = "Public IP of Web Server 2"
  value       = aws_instance.web_server_2.public_ip
}

output "ssh_connection_test" {
  description = "Commands to test SSH connection"
  value = <<-EOF
Test SSH connections:
ssh -i ansible-key.pem ubuntu@${aws_instance.web_server_1.public_ip}
ssh -i ansible-key.pem ubuntu@${aws_instance.web_server_2.public_ip}

Test Ansible connection:
ansible all -m ping
EOF
}

# 🎓 What This Infrastructure Creates:
# 1. 2x Ubuntu 22.04 t3.micro instances (free tier eligible)
# 2. SSH key pair for secure Ansible connection
# 3. Security group allowing SSH, HTTP, HTTPS access
# 4. Ansible inventory and configuration files
# 5. Minimal server setup for Python/Ansible compatibility

# 💰 Cost Estimation:
# - 2x t3.micro: $0.0116/hour each = $0.0232/hour total
# - Data transfer: minimal for learning
# - Total: ~$0.50 for 20 hours of learning

# 🔒 Security Notes:
# - SSH keys are generated automatically
# - Security group restricts access to necessary ports
# - Servers are in public subnets for simplicity
# - Private key file has proper permissions (0600)

# 🚀 Next Steps After Deployment:
# 1. Wait 2-3 minutes for servers to fully boot
# 2. Test SSH: ssh -i ansible-key.pem ubuntu@SERVER_IP
# 3. Test Ansible: ansible all -m ping
# 4. Run your first playbook!