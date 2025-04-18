/**
 * This will provide the proper permission for terragrunt group to access terragrunt state bucket
 *
 * Created April 18th, 2025
 * @ywarezk
 */

variable "terragrunt_group" {
	type = string
}

resource "google_storage_bucket_iam_member" "stoage_terragrunt_state" {
	bucket = "academeez-k8s-flux-terragrunt-state"
	role   = "roles/storage.admin"
	member = "group:${var.terragrunt_group}"
}