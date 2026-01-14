/**
 * Create the root folder, all the resources will be created under this folder
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "folder" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/folder/terragrunt.hcl"
}

inputs = {
  names = ["academeez-k8s-flux"]
}