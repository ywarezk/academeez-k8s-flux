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

inputs = {
  project              = try(values.project, "")
  service_accounts     = try(values.service_accounts, [])
  mode                 = try(values.mode, "additive")
  bindings             = try(values.bindings, {})
  conditional_bindings = try(values.conditional_bindings, [])
}
