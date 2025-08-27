include "root" {
    path = find_in_parent_folders("root.hcl")   
}

inputs = {
  environment    = "dev"
  instance_type  = "t3.micro"
  instance_count = 2
}