# Configure a common remote state backend for everything
remote_state {
  backend = "s3"
  config = {
    bucket         = "xenium-tf-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    # dynamodb_table = "terraform-locks"
  }
}

# Generate the required backend block for Terraform
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

# 3. Generate your provider.tf (Moved provider out of the backend block)
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "ap-southeast-2"
}
EOF
}


generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.34"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
  }
}
EOF
}

# Inputs that are common to all environments
inputs = {
  company_name = "xenium"
  aws_region   = "ap-southeast-2"
}