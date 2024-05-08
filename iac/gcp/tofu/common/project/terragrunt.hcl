#
# shared project for all environments
# Often you will want to create a different project for each environment,
# but to simplify the setup we will use a single project for all environments
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

# this includes the common parent configurations
include "root" {
  path = find_in_parent_folders()
}

terraform {
	source = "."
}

locals {
	common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
	project = local.common_vars.project
	org_id = local.common_vars.org_id
	billing_account = local.common_vars.billing_account
	folder_id = local.common_vars.folder_id
}