/**
 * Google Cloud group unit.
 *
 * Wraps terraform-google-modules/group/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

terraform {
  source = "tfr:///terraform-google-modules/group/google?version=0.8.0"
}
