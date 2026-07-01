/**
 * Google Cloud folder unit.
 *
 * Wraps terraform-google-modules/folders/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

terraform {
  source = "tfr:///terraform-google-modules/folders/google?version=5.1.0"
}
