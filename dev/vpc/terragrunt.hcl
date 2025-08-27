# The URL used here is a shorthand for
# "tfr://registry.terraform.io/terraform-aws-modules/eks/aws?version=20.0.0".
# Note the extra `/` after the protocol is required for the shorthand
# notation.

terraform {
  # Source of the module to call. This is the only place this is defined.
  source  = "tfr:///terraform-aws-modules/vpc/aws?version=6.0.1"
}

# Include the environment and root config
include "env" {
  path = find_in_parent_folders("root.hcl")
}

# Pass inputs to the module
inputs = {
  cidr = "10.0.0.0/16"
  name = "xen-main-vpc"
  # instance_type from dev/terragrunt.hcl is automatically available
  # but can be overridden here if needed.
}