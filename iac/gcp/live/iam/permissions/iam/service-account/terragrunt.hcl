/**
 * IAM bindings for Google Cloud service accounts.
 *
 * Wraps terraform-google-modules/iam/google//modules/service_accounts_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/service_accounts_iam?version=8.1.0"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

dependency "admin_group" {
  config_path = "../../../groups/admin"
}

dependency "iam_project" {
  config_path = "../../../project"
}

inputs = {
  project          = dependency.iam_project.outputs.project_id
  service_accounts = [dependency.iam_sa.outputs.email]
  mode             = try(values.mode, "additive")
  bindings = {
    "roles/iam.serviceAccountTokenCreator" : [
      "group:${dependency.admin_group.outputs.id}"
    ]
  }
  conditional_bindings = try(values.conditional_bindings, [])
}
