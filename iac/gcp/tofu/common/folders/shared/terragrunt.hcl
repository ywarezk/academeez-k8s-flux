

include "root" {
	path   = find_in_parent_folders()
}

include "folder" {
	path = "${dirname(find_in_parent_folders())}/_env/folder.hcl"
}

dependency "root_folder" {
	config_path = "../root"
}

inputs = {
	parent = dependency.root_folder.outputs.id
	names = [ "shared" ]
}