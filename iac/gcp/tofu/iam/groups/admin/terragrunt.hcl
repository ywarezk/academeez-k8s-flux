


include "root" {
  path = find_in_parent_folders()
}

include "group" {
  path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
  id           = "k8s-flux-admin@academeez.com"
  display_name = "k8s-flux-admin"
  description  = "k8s flux admin group"
  members      = ["k8s-flux@academeez.com"]
}