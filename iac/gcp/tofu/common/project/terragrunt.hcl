

include "root" {
	path   = find_in_parent_folders()
}

include "project" {
	path = "${dirname(find_in_parent_folders())}/_env/project.hcl"
}

dependency "shared_folder" {
	config_path = "../folders/shared"
}

inputs = {
	folder_id = dependency.shared_folder.outputs.id
	name = "academeez-k8s-flux-common"
}