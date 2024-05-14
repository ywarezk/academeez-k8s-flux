#
# Shared GKE logic
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region      = local.region_vars.locals.region
  env         = basename(dirname(get_terragrunt_dir()))
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_env/gke/main.tf"
}

# load project dependency from common/project
dependency "project" {
  config_path = "${dirname(find_in_parent_folders())}/common/project"
}

# we can only create this after vpc is created
dependency "vpc" {
  config_path = "${dirname(find_in_parent_folders())}/${local.env}/vpc"
}

inputs = {
  project                  = dependency.project.outputs.project.project_id
  region                   = local.region
  name                     = local.env
  network                  = dependency.vpc.outputs.vpc.network_name
  subnetwork               = dependency.vpc.outputs.vpc.subnets_names[0]
  subnets_secondary_ranges = dependency.vpc.outputs.vpc.subnets_secondary_ranges[0]
}
