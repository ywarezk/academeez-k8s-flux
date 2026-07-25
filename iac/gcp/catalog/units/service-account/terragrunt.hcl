/**
 * Google Cloud service account unit.
 *
 * Wraps terraform-google-modules/service-accounts/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/service-accounts/google?version=4.7.0"
}
