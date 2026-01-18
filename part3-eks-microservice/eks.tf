
# 🏢 EKS (Elastic Kubernetes Service) - Your Application Management System  
# Think of this as hiring a building manager who handles all the day-to-day operations

# Create a managed Kubernetes cluster using AWS EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"  # Pre-built, battle-tested EKS setup
  version = "~> 20.0"                        # Latest stable version (better reliability)

  # Cluster basic settings
  cluster_name    = "student-eks-cluster"  # Name of your Kubernetes cluster
  cluster_version = "1.28"                 # Stable Kubernetes version (1.29 can have issues)

  # Connect to our VPC (the network we created)
  vpc_id                          = module.vpc.vpc_id           
  subnet_ids                      = module.vpc.private_subnets  
  control_plane_subnet_ids        = module.vpc.private_subnets
  
  # Enable cluster endpoint access
  cluster_endpoint_public_access  = true   # Allow access from internet (needed for kubectl)
  cluster_endpoint_private_access = true   # Also allow private access
  
  # Enable logging for troubleshooting
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # EKS Managed Node Groups (more reliable than self-managed)
  eks_managed_node_groups = {
    # Primary node group
    student_nodes = {
      # Node group basics
      name            = "student-nodes"
      use_name_prefix = false
      
      # Instance configuration - using more reliable settings
      instance_types = ["t3.medium", "t3a.medium"]  # Multiple types for better availability
      capacity_type  = "ON_DEMAND"                   # More reliable than SPOT for learning
      
      # Scaling configuration
      min_size     = 1    # Minimum nodes
      max_size     = 3    # Maximum nodes  
      desired_size = 2    # Start with 2 nodes
      
      # Network configuration
      subnet_ids = module.vpc.private_subnets
      
      # Security and access
      remote_access = {
        ec2_ssh_key = null  # No SSH key needed for managed nodes
      }
      
      # Disk configuration
      disk_size = 20  # 20GB disk (enough for learning)
      
      # Labels and tagging
      labels = {
        Environment = "learning"
        NodeGroup   = "student-nodes"
      }
      
      # Taints (none for general purpose nodes)
      taints = []
      
      # Update configuration
      update_config = {
        max_unavailable_percentage = 50  # Allow 50% nodes to update at once
      }
    }
  }

  # Cluster access configuration
  access_entries = {
    # Root user access (automatic with current AWS credentials)
    root_user = {
      kubernetes_groups = ["system:masters"]
      principal_arn     = data.aws_caller_identity.current.arn
      
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  # Add-ons for better functionality
  cluster_addons = {
    # Core networking
    coredns = {
      most_recent = true
    }
    # Pod networking
    vpc-cni = {
      most_recent = true
    }
    # Storage
    ebs-csi-driver = {
      most_recent = true
    }
    # Networking proxy
    kube-proxy = {
      most_recent = true
    }
  }

  # Tags for all resources
  tags = {
    Environment = "learning"
    Project     = "terraform-training"
    ManagedBy   = "terraform"
  }
}

# Data source to get current AWS account info
data "aws_caller_identity" "current" {}

# Output important information
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_iam_role_name" {
  description = "IAM role name associated with EKS cluster"
  value       = module.eks.cluster_iam_role_name
}

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.eks.eks_managed_node_groups
}

# 🎓 What Changed for Better Reliability:
# 1. Updated to latest EKS module version (20.x)
# 2. Added explicit access entries for root user
# 3. Multiple instance types for better availability 
# 4. Added essential cluster add-ons
# 5. Better logging and monitoring
# 6. More robust node group configuration
# 7. Proper tagging for resource management

# 💡 Why These Changes Help:
# - Latest module = fewer bugs and better AWS API support
# - Multiple instance types = if t3.medium unavailable, uses t3a.medium
# - Access entries = explicit permissions (works better with root)
# - Add-ons = essential Kubernetes functionality pre-installed
# - Better logging = easier troubleshooting if issues occur

# 🚀 Expected Behavior:
# - Cluster creation: 10-12 minutes (more reliable timing)
# - Node group creation: 3-5 minutes after cluster ready
# - Total time: 15-17 minutes (more predictable)
