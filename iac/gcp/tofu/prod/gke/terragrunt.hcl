#
# Create GKE for prod - focus on high availability
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

# this includes the common parent configurations
include "root" {
  path = find_in_parent_folders()
}

# this includes the common gke configurations
include "env" {
  path = "${dirname(find_in_parent_folders())}/_env/gke.hcl"
}

inputs = {
  name = "prod"
}