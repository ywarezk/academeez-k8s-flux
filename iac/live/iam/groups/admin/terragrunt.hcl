


include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "group" {
  path = "${get_repo_root()}/iac/catalog/units/group/terragrunt.hcl"
}

inputs = {
  id           = "k8s-flux-admin@academeez.com"
  display_name = "k8s-flux-admin"
  description  = "k8s flux admin group"
  members      = ["k8s-flux@academeez.com"]
}