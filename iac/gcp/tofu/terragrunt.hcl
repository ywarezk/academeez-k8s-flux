
locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  
  # this will allow us to switch region between dev/prod to save costs
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region   = local.region_vars.locals.region
  project  = local.common_vars.project
}

# Create remote state in s3
remote_state {
  backend = "gcs"
  config = {
    bucket  = local.common_vars.state_bucket
    project = local.common_vars.project
    prefix  = path_relative_to_include()
    location = "eu"  
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(  
  local.region_vars.locals
)