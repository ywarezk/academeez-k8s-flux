#
# Bootstrapping flux to our cluster
#
# Created May 14th, 2024
# @author ywarezk
# @license MIT
#

include "root" {
  path = find_in_parent_folders()
}

include "flux" {
  path = "${dirname(find_in_parent_folders())}/_env/flux/flux.hcl"
}