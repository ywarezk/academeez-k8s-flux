/**
 * this will create the devops group
 * The devops group can create certain cloud resources like gke, dns, storage, etc.
 * all in the realm of the course root folder
 *
 * Created April 18th, 2025
 * @ywarezk
 *
 */

include "root" {
  path = find_in_parent_folders()
}

include "group" {
  path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
  description  = "Devops group of developers"
  display_name = "Academeez K8s Flux DevOps Group"
  id           = "academeez-k8s-flux-devops@academeez.com"
  members = [
    "k8s-flux@academeez.com"
  ]
}