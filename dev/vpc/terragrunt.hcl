include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Read the env config for its inputs
locals {
  env_config = read_terragrunt_config(find_in_parent_folders(""))
  root_config = read_terragrunt_config(find_in_parent_folders("root.hcl"))
  vpc_name = "${local.root_config.inputs.company_name}-${local.env_config.inputs.environment}-vpc"
}


# 2. Read the ENVIRONMENT config to get its inputs (which already include root inputs)
# locals {
#   env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
# }

# 3. Merge module-specific inputs with the already-merged environment inputs
inputs = {
  cidr = "19.0.0.0/16"
  name = local.vpc_name
}

terraform {
  # Source of the module to call. This is the only place this is defined.
  source  = "tfr:///terraform-aws-modules/vpc/aws?version=6.0.1"

  # # Add this 'after_helpers' block to create a file in the temporary module directory
  # after_hook "add_debug_output" {
  #   commands = ["plan", "apply"]
  #   execute  = ["bash", "-c", <<-EOF
  #     cat > .terragrunt-debug-outputs.tf << 'OUTPUTS'
  #     output "terragrunt_inputs" {
  #       description = "All inputs merged for this module"
  #       value       = {
  #         company_name   = "${local.env_config.inputs.company_name}"
  #         aws_region     = "${local.env_config.inputs.aws_region}"
  #         environment    = "${local.env_config.inputs.environment}"
  #         instance_type  = "${local.env_config.inputs.instance_type}"
  #         instance_count = "${local.env_config.inputs.instance_count}"
  #         vpc_name       = "xen-main-vpc"
  #         vpc_cidr       = "10.0.0.0/16"
  #       }
  #     }
  #     OUTPUTS
  #   EOF
  #   ]
  # }

}

