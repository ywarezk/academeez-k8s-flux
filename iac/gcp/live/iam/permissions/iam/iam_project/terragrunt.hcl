/**
 * IAM bindings for Google Cloud projects.
 *
 * Wraps terraform-google-modules/iam/google//modules/projects_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/projects_iam?version=8.1.0"
}

dependency "iam_project" {
  config_path = "../../../project"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

inputs = {
  projects = [dependency.iam_project.outputs.project_id]
  mode     = try(values.mode, "additive")
  bindings = {
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
  conditional_bindings = try(values.conditional_bindings, [])
}
