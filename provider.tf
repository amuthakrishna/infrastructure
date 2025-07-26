# infrastructure/backend.tf

terraform {
  backend "s3" {
    bucket  = "mallowtech-dev-terraform-state"
    key     = "terraform.tfstate"
    region  = "ap-south-1" # Change if your bucket is in a different region
    encrypt = true

  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}
