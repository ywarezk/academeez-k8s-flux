/**
 * Create the root folder, all the resources will be created under this folder
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

locals {
  org_id = local.common_vars.org_id
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "folder" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/folder/terragrunt.hcl"
}

inputs = {
  parent = "organizations/${local.org_id}"
  names  = ["academeez-k8s-flux"]
}
