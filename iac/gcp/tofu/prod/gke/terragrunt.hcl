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
include "gke" {
  path = "${dirname(find_in_parent_folders())}/_env/gke/gke.hcl"
}

inputs = {
  regional           = true
  zones              = ["us-central1-a", "us-central1-b", "us-central1-c"]
  initial_node_count = 1
  min_node_count     = 3
  max_node_count     = 5
  preemptible        = false
  spot               = false
  autoscaling        = true
}