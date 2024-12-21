/**
 * The common resources that are shared between the environments will be under the common project
 *
 * Created December 15th, 2024
 * @author ywarezk
 */

include "root" {
  path = find_in_parent_folders()
}

include "project" {
  path = "${dirname(find_in_parent_folders())}/_env/project.hcl"
}

# since the project will be under the shared folder we will grab it using the dependency block
dependency "shared_folder" {
  config_path = "../folders/shared"
}

inputs = {
  folder_id = dependency.shared_folder.outputs.id
  name      = "academeez-k8s-flux-common"
}