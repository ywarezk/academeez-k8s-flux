/**
 * this will create the developers group
 * The developers group can be users of the staging db and users of gke
 * They cannot create cloud resources
 *
 * Created April 18th, 2025
 * @ywarezk
 */

include "root" {
  path = find_in_parent_folders()
}

include "group" {
  path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
  description  = "Developers group"
  display_name = "Academeez K8s Flux Developers Group"
  id           = "academeez-k8s-flux-developers@academeez.com"
  members = [
    "k8s-flux@academeez.com"
  ]
}