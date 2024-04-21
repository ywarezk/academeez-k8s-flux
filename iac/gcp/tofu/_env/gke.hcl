#
# Terragrunt file for global GKE configurations
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

terraform {
  source = "git::git@github.com:terraform-google-modules/terraform-google-kubernetes-engine.git?ref=v30.2.0"
}

# load project dependency from common/project
dependency "project" {
  config_path = "${dirname(find_in_parent_folders())}/common/project"
}
