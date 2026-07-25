/**
 * IAM bindings for Google Cloud projects.
 *
 * Wraps terraform-google-modules/iam/google//modules/projects_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/projects_iam?version=8.1.0"
}
