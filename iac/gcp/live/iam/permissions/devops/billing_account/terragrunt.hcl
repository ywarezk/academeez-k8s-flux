/**
 * IAM bindings for Google Cloud billing accounts.
 *
 * Wraps terraform-google-modules/iam/google//modules/billing_accounts_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/billing_accounts_iam?version=8.1.0"
}

dependency "devops_sa" {
  config_path = "../../../service-accounts/devops"
}

inputs = {
  billing_account_ids = [include.root.locals.billing_account]
  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${dependency.devops_sa.outputs.email}"
    ]
  }
  mode = try(values.mode, "additive")
}
