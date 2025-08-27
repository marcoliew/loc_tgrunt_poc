# Include all settings from the root file
include "root" {
  path = find_in_parent_folders("root.hcl") # Automatically finds the root file
}

# Set environment-specific inputs
inputs = {
  environment = "dev"
  instance_type = "t3.micro"
  instance_count = 1
}