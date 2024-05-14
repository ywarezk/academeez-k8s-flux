#
# Each environment should have its own VPC.
# In that vpc we will create a single subnet to the GKE cluster.
# We will also create 2 secondary ranges for the pods and services.
#
# Created May 9th, 2024
# @author ywarezk
# @license MIT
#

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.region
}

dependency "project" {
  config_path = "${dirname(find_in_parent_folders())}/common/project"
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_env/vpc/main.tf"
}

inputs = {
  name    = basename(dirname(get_terragrunt_dir()))
  project = dependency.project.outputs.project.project_id
  region  = local.region
}