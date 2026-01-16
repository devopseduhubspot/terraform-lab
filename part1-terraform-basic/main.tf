
# 📚 Part 1: Your First Terraform Code
# This code creates a simple text file on your computer

# Tell Terraform what tools we need
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"  # Tool for creating local files
    }
  }
}

# Create a text file
resource "local_file" "hello" {
  filename = "hello.txt"                                    # Name of the file
  content  = "Hello Students, this is your first Terraform code!"  # What goes inside
}

# 🎓 What this code does:
# 1. Downloads the "local" provider (file creation tool)
# 2. Creates a file named "hello.txt" 
# 3. Puts the message inside the file
# 4. When you run "terraform destroy", it deletes the file

# 💡 Key Concept: Infrastructure as Code
# Instead of manually creating files, you describe what you want in code,
# and Terraform makes it happen automatically!
