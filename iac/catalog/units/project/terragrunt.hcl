/**
 * Google Cloud project unit.
 *
 * Wraps terraform-google-modules/project-factory/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

terraform {
  source = "tfr:///terraform-google-modules/project-factory/google?version=18.3.0"
}
