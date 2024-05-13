#
# Create the vpc in dev environment
#
# Created May 10th, 2024
# @author ywarezk
# @license MIT
#

include "root" {
  path = find_in_parent_folders()
}

include "vpc" {
  path = "${dirname(find_in_parent_folders())}/_env/vpc/vpc.hcl"  
}