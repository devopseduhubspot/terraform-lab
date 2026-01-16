
provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "terraform-student-demo-bucket-12345"
  force_destroy = true
}
