/**
 * IAM bindings for Google Cloud folders.
 *
 * Wraps terraform-google-modules/iam/google//modules/folders_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/folders_iam?version=8.1.0"
}
