
# 🏢 EKS (Elastic Kubernetes Service) - Your Application Management System  
# Think of this as hiring a building manager who handles all the day-to-day operations

# Create a managed Kubernetes cluster using AWS EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"  # Pre-built, battle-tested EKS setup
  version = "19.0.0"                         # Stable version

  # Cluster basic settings
  cluster_name    = "student-eks-cluster"  # Name of your Kubernetes cluster
  cluster_version = "1.29"                 # Kubernetes version (latest stable)

  # Connect to our VPC (the network we created)
  vpc_id     = module.vpc.vpc_id           # Use the VPC ID from vpc.tf
  subnet_ids = module.vpc.private_subnets  # Place worker nodes in private subnets (more secure)

  # Worker nodes configuration (the computers that run your applications)
  eks_managed_node_groups = {
    default = {
      # Node scaling settings
      desired_size = 2              # Start with 2 worker computers
      min_size     = 1              # Minimum 1 computer (for cost savings)
      max_size     = 3              # Maximum 3 computers (for traffic spikes)
      
      # Computer specifications
      instance_types = ["t3.medium"]  # Each computer: 2 CPUs, 4GB RAM (~$0.042/hour each)
    }
  }
}

# 🎓 Real-World Analogy:
# EKS Cluster = Building management company
# Worker Nodes = Individual office spaces  
# Kubernetes = The management software
# Containers = Individual applications/services
# Auto-scaling = Automatically rent more offices during busy periods

# 💡 Why Kubernetes:
# - Automatic healing: If an app crashes, restart it
# - Load balancing: Distribute traffic across multiple app instances  
# - Scaling: Add/remove app instances based on demand
# - Rolling updates: Deploy new versions without downtime
# - Resource management: Efficiently use computer resources

# 🏢 Who Uses This:
# - Netflix: Manages thousands of microservices
# - Uber: Handles millions of ride requests
# - Spotify: Streams music to millions of users
# - Banking apps: Process financial transactions
# - E-commerce: Handle shopping traffic spikes

# 💰 Cost Breakdown:
# - EKS Control Plane: $0.10/hour ($2.40/day) - AWS manages this
# - Worker Nodes: 2 × t3.medium = $0.084/hour ($2/day) - You pay for compute
# - Total: ~$4.40/day for production-grade infrastructure!

# 🚀 What You Get:
# - Production-grade container orchestration
# - Automatic scaling and healing
# - Load balancing
# - Rolling deployments
# - Multi-zone high availability  
# - Enterprise security features
