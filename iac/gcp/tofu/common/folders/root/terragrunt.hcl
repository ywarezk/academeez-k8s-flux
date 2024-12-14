

include "root" {
  path   = find_in_parent_folders()
}

include "folder" {
	path = "${dirname(find_in_parent_folders())}/_env/folder.hcl"
}

inputs = {
	names = [ "academeez-k8s-flux" ]
}