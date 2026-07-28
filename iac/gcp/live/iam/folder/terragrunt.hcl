/**
 * Google Cloud folder unit.
 *
 * Wraps terraform-google-modules/folders/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/folders/google?version=5.1.0"
}

# since this folder is under the root folder we will use dependency to get the parent folder
dependency "root_folder" {
  config_path = "../../common/folders/root"
}

inputs = {
  parent              = dependency.root_folder.outputs.id
  names               = values.names
  prefix              = try(values.prefix, "")
  deletion_protection = try(values.deletion_protection, true)
  set_roles           = try(values.set_roles, false)
  per_folder_admins   = try(values.per_folder_admins, {})
  all_folder_admins   = try(values.all_folder_admins, [])
  folder_admin_roles = try(values.folder_admin_roles, [
    "roles/owner",
    "roles/resourcemanager.folderViewer",
    "roles/resourcemanager.projectCreator",
    "roles/compute.networkAdmin",
  ])
}
