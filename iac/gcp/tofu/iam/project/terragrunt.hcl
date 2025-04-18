/**
 * this will create the iam project under the iam folder
 *
 * Created April 18th, 2025
 * @ywarezk
 */

include "root" {
  path = find_in_parent_folders()
}

include "project" {
  path = "${dirname(find_in_parent_folders())}/_env/project.hcl"
}

# since the project will be under the shared folder we will grab it using the dependency block
dependency "iam_folder" {
  config_path = "../folder"
}

inputs = {
  folder_id = dependency.iam_folder.outputs.id
  name      = "academeez-k8s-flux-iam"
}