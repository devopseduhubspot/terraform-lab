
# 🏗️ VPC (Virtual Private Cloud) - Your Network Foundation
# Think of this as building the roads, neighborhoods, and infrastructure for your applications

# Create a complete VPC using a proven module (like hiring experienced contractors)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # Pre-built, tested VPC code
  version = "5.5.0"                          # Specific version for reliability

  # Basic VPC settings
  name = "student-eks-vpc"     # Name of your virtual network
  cidr = "10.0.0.0/16"         # IP address range (65,536 possible addresses)

  # Availability Zones (like different neighborhoods for redundancy)
  azs = ["ap-south-1a", "ap-south-1b"]  # Two zones in Mumbai for high availability

  # Private subnets (internal networks, more secure)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]    # 256 IPs each
  
  # Public subnets (internet-facing networks)  
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]  # 256 IPs each

  # NAT Gateway settings (allows private servers to access internet)
  enable_nat_gateway = true   # Required for EKS nodes to download container images
  single_nat_gateway = true   # Use 1 gateway (cheaper) instead of 2 (more reliable)
}

# 🎓 Real-World Analogy:
# VPC = Your company's private campus
# Public subnets = Reception areas (internet access)
# Private subnets = Secure office spaces (no direct internet)
# NAT Gateway = Secure internet checkpoint for private areas
# Availability Zones = Different buildings for backup

# 💡 Why This Setup:
# - Private subnets: Keep application servers secure
# - Public subnets: Handle internet traffic via load balancers
# - Multiple AZs: If one fails, the other continues
# - Single NAT: Saves $45/month vs dual NAT setup

# 🏢 Enterprise Examples:
# Netflix, Uber, Airbnb all use similar VPC architectures
# This is production-grade networking!
