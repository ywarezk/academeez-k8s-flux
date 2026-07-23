/**
 * Create the root folder, all the resources will be created under this folder
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "folder" {
  path = "${get_repo_root()}/iac/gcp/catalog/units/folder/terragrunt.hcl"
}

inputs = {
  parent = "organizations/${include.root.locals.org_id}"
  names  = ["academeez-k8s-flux"]
}
