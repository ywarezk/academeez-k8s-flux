#
# Create GKE for dev - focus on low cost
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
include "gke" {
  path = "${dirname(find_in_parent_folders())}/_env/gke/gke.hcl"  
}

inputs = {  
  regional = false
  zones = ["asia-southeast1-a"]
  initial_node_count = 1
}