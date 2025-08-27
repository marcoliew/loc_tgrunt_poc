include "root" {
    path = find_in_parent_folders("root.hcl")   
}

inputs = {
  #environment    = "dev"
  instance_type  = "t3.micro"
  instance_count = 2
  environment    = basename(path_relative_to_include())
}

locals {
  region      = "ap-southeast-2"
    # This is the magic. Derives the environment name from the folder structure.
    # basename(path_relative_to_include()) for path 'dev/vpc' returns 'vpc'
    # basename(path_relative_to_include()) for path 'dev' returns 'dev'
  #environment = 
}
