/**
 * IAM bindings for Google Cloud service accounts.
 *
 * Wraps terraform-google-modules/iam/google//modules/service_accounts_iam.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl.
 */

terraform {
  source = "tfr:///terraform-google-modules/iam/google//modules/service_accounts_iam?version=8.1.0"
}
