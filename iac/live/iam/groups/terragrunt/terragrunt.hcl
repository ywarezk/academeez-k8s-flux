


include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "group" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/group/terragrunt.hcl"
}

dependency "admin_group" {
  config_path = "../admin"
}

inputs = {
  id           = "k8s-flux-terragrunt@academeez.com"
  display_name = "k8s-flux-terragrunt"
  description  = "k8s flux terragrunt bucket"
  members      = [dependency.admin_group.outputs.id]
}