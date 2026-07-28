/**
 * IAM bindings for Google Cloud folders.
 *
 * Wraps terraform-google-modules/iam/google//modules/folders_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/folders_iam?version=8.1.0"
}

# since the project will be under the shared folder we will grab it using the dependency block
dependency "root_folder" {
  config_path = "../../../../common/folders/root"
}

dependency "devops_sa" {
  config_path = "../../../service-accounts/devops"
}

inputs = {
  folders = [dependency.root_folder.outputs.id]
  mode    = try(values.mode, "additive")
  bindings = {
    "roles/resourcemanager.projectCreator" = [
      "serviceAccount:${dependency.devops_sa.outputs.email}"
    ]
  }
  conditional_bindings = try(values.conditional_bindings, [])
}
