#
# Create a gcp project to store all the infastructure
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

locals {
	common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

terraform {    
  source = "git::git@github.com:terraform-google-modules/terraform-google-project-factory.git?ref=v14.5.0"
}

inputs = {
	name = local.common_vars.project
	random_project_id = false
	org_id = local.common_vars.org_id
	billing_account = local.common_vars.billing_account
  auto_create_network = false
  create_project_sa = false
  random_project_id = false
	activate_apis = []
}