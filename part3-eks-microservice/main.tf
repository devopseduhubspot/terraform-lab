
# 🏢 Part 3: Professional Web Application Infrastructure
# This is the main configuration file that sets up AWS connection

# Tell Terraform to use AWS
provider "aws" {
  region = "ap-south-1"  # Mumbai, India region
}

# 🎓 What this file does:
# This is the "master" file that tells Terraform we're using AWS.
# The actual infrastructure is defined in separate files:
# - vpc.tf: Creates the network foundation
# - eks.tf: Creates the Kubernetes cluster

# 💡 File Organization:
# Real projects split code into multiple files for organization:
# - main.tf: Provider configuration
# - vpc.tf: Networking resources  
# - eks.tf: Kubernetes resources
# - variables.tf: Input parameters (we'll keep it simple for now)
# - outputs.tf: Return values (advanced topic)

# ⚠️ COST WARNING:
# This setup costs $2-5/day when running
# Infrastructure includes:
# - EKS cluster: $2.40/day
# - Worker nodes: $2/day  
# - NAT gateway: $1/day
# - Load balancer: $0.60/day
# ALWAYS run cleanup within 1 hour!
