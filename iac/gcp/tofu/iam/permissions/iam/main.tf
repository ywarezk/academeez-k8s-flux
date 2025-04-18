/**
 * This will create the proper roles for the iam service account
 * That service account can:
 * - Create groups
 * - Create service accounts
 * - Create roles in the realm of the course
 *
 * Created April 18th, 2025
 * @ywarezk
 */

variable "iam_project" {
	description = "The project id of the iam project"
	type        = string
}

variable "iam_sa" {
	description = "The iam service account email"
	type        = string
}

variable "iam_sa_name" {
	description = "The iam service account name"
	type        = string
}

variable "root_folder" {
	description = "The root folder id"
	type        = string
}

variable "billing_project" {
	description = "The billing project id"
	type        = string
}

variable "admin_group" {
	description = "The admin group email"
	type        = string
}

# iam can create service account in the project
resource "google_project_iam_binding" "create_sa" {
	project = var.iam_project
	role    = "roles/iam.serviceAccountAdmin"

	members = [
		"serviceAccount:${var.iam_sa}"
	]
}

# google_folder_iam_binding for the role roles/resourcemanager.projectIamAdmin on the root folder of the course
resource "google_folder_iam_binding" "assign_iam_policies" {
	folder = var.root_folder
	role   = "roles/resourcemanager.projectIamAdmin"

	members = [
		"serviceAccount:${var.iam_sa}"
	]
}

# place the role: roles/serviceusage.serviceUsageConsumer on the billing_project
resource "google_project_iam_member" "billing_project_service_usage" {
	project = var.billing_project
	role    = "roles/serviceusage.serviceUsageConsumer"
	member = "serviceAccount:${var.iam_sa}"
}

# allow the admin group to impersonate the var.iam_sa
resource "google_service_account_iam_binding" "impersonate_iam_sa" {
	service_account_id = var.iam_sa_name
	role               = "roles/iam.serviceAccountTokenCreator"
	members = [
		"group:${var.admin_group}"
	]
}