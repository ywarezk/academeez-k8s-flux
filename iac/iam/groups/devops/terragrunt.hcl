


include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "group" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_modules/group.hcl"
}

inputs = {
  id           = "k8s-flux-devops@academeez.com"
  display_name = "k8s-flux-devops"
  description  = "k8s flux devops group"
  members      = ["k8s-flux@academeez.com"]
}