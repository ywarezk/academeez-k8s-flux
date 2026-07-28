/**
 * IAM bindings for Google Cloud Storage buckets.
 *
 * Wraps terraform-google-modules/iam/google//modules/storage_buckets_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/storage_buckets_iam?version=8.1.0"
}

dependency "terragrunt_group" {
  config_path = "../../../groups/terragrunt"
}

inputs = {
  storage_buckets = try(values.storage_buckets, [])
  mode            = try(values.mode, "additive")
  bindings = {
    "roles/storage.admin" = [
      "group:${dependency.terragrunt_group.outputs.id}",
    ]
  }
  conditional_bindings = try(values.conditional_bindings, [])
}
