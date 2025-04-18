/**
 * this will create the admin group
 * Members of the admin group can:
 * - Create and manage groups
 * - Create and manage service accounts under the iam project
 * - Create and manage roles under the course folder
 *
 * Created April 18th, 2025
 * @author: ywarezk
 */

include "root" {
  path = find_in_parent_folders()
}

include "group" {
  path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
  description  = "Admin group is managing iam roles, groups, and gcp service accounts"
  display_name = "Academeez K8s Flux Admin Group"
  id           = "academeez-k8s-flux-admin@academeez.com"
  members = [
    "k8s-flux@academeez.com"
  ]
}