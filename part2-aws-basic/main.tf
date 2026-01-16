
# 🌍 Part 2: Your First AWS Cloud Resource
# This code creates cloud storage (S3 bucket) in AWS

# Tell Terraform to use AWS
provider "aws" {
  region = "ap-south-1"  # Mumbai, India region (cheap and fast for Indian users)
}

# Create an S3 bucket (cloud storage)
resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "terraform-student-demo-bucket-12345"  # Unique name across all AWS
  force_destroy = true                                   # Allow deletion even with files inside
}

# 🎓 What this code does:
# 1. Connects to AWS in Mumbai region
# 2. Creates a storage bucket (like a folder in the cloud)
# 3. Names it with a unique identifier
# 4. Allows easy cleanup with "terraform destroy"

# 💡 Real-World Usage:
# - Websites store images/videos in S3
# - Apps backup data to S3
# - Companies store documents in S3
# - Netflix uses similar storage for movies!

# ⚠️ COST WARNING:
# This costs ~$0.01/day if left running
# Always run "terraform destroy" to avoid charges!
