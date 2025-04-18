/**
 * this will create the terragrunt group
 * The terragrunt group will give permission to access the state bucket so a member can run terragrunt apply
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
  description  = "Terragrunt group of developers that can run IAC"
  display_name = "Academeez K8s Flux Terragrunt Group"
  id           = "academeez-k8s-flux-terragrunt@academeez.com"
  members = [
    "k8s-flux@academeez.com"
  ]
}