#
# shared project for all environments
# Often you will want to create a different project for each environment,
# but to simplify the setup we will use a single project for all environments
#
# Created April 15th, 2024
# @author ywarezk
# @license MIT
#

# this includes the common parent configurations
include "root" {
  path = find_in_parent_folders()
}

include "project" {	
	path = "${dirname(find_in_parent_folders())}/_env/project.hcl"	
}