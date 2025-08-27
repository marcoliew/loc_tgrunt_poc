# Your wrapper module calls the upstream module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  # Set smart defaults and enforce standards HERE, once and for all.
  name = var.name
  cidr = var.cidr

  # Hardcode or compute complex values that you always want
  azs = ["ap-southeast-2a", "ap-southeast-2b"] # Always use these AZs
  enable_nat_gateway = true                     # We always want a NAT GW
  single_nat_gateway = true                     # We always want only one for cost
  one_nat_gateway_per_az = false

  # Define tags for all resources in one place
  tags = merge(
    var.default_tags,
    {
      Name = var.name
      Tier = "network"
    }
  )

  # Let the user override only the things that should change (like subnets)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}