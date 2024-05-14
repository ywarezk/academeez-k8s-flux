#
# Create tofu resources
# - tofu service account
# - Give proper minimal permissions on the project to tofo service account
# - Create a remote state bucket for tofu to manage states
#
# Created May 4th, 2024
# @author ywarezk
# @license MIT
#

# this includes the common parent configurations
include "root" {
  path = find_in_parent_folders()
}

# terragrunt dependency on common/project
dependency "project" {
  config_path = "${dirname(find_in_parent_folders())}/common/project"
}

# create a terragrunt terraform block to point to the module
terraform {
  source = "${dirname(find_in_parent_folders())}/common/tofu/main.tf"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  project          = dependency.project.outputs.project.project_id
  state_bucket     = local.common_vars.state_bucket
  grp_tofu_members = local.common_vars.grp_tofu_members
}