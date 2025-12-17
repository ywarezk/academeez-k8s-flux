/**
 * this will assign iam permission to the root folder of the course
 *
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "iam_folder" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_modules/iam/folder.hcl"
}

# since the project will be under the shared folder we will grab it using the dependency block
dependency "root_folder" {
  config_path = "../../../../common/folders/root"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

inputs = {
  folders = [dependency.root_folder.outputs.id]
  mode    = "authoritative"
  bindings = {
    "roles/iam.securityAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ],
    "roles/resourcemanager.folderViewer" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}