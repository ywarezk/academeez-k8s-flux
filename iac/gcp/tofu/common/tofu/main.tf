# 
# Entry point for the module that terragrunt will execute
#  include creating the service account and permissions
#
#  Created May 4th, 2024
#  @author ywarezk
#  @license MIT
# 

variable "project" {
  type        = string
  description = "The project id of the course project"
}

variable "state_bucket" {
  type        = string
  description = "The bucket to store the state"
}

variable "grp_tofu_members" {
  type        = list(string)
  description = "The group of memebers that can impersonate the tofu service account"
}

# create a bucket for tofu state
resource "google_storage_bucket" "bkt_tofu_state" {
  name     = var.state_bucket
  location = "US"
  project  = var.project
}

# create a google service account for tofu
resource "google_service_account" "sa_tofu" {
  account_id   = "sa-tofu"
  display_name = "Service account for tofu"
  project      = var.project
}

# tofu service account should have binding full control on the google_storage_bucket.tofu_state
# careful with the binding resources cause they are not idempotent
resource "google_storage_bucket_iam_binding" "allow_sa_tofu_bkt_tofu_state" {
  bucket = google_storage_bucket.bkt_tofu_state.name
  role   = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.sa_tofu.email}"
  ]
}

# create a group for users that can impersonate the tofu service account
module "grp_tofu_impersonators" {
  source       = "terraform-google-modules/group/google"
  version      = "~> 0.6"
  id           = "k8s-flux-tofu@academeez.com"
  display_name = "k8s-flux-tofu"
  description  = "Group of users that can impersonate the tofu service account in this course"
  domain       = "academeez.com"
  owners       = []
  managers     = []
  members      = var.grp_tofu_members
}

# allow grp_tofu_impersonators to impersonate the tofu service account roles/iam.serviceAccountTokenCreator
resource "google_service_account_iam_binding" "allow_grp_tofu_impersonate_sa_tofu" {
  service_account_id = google_service_account.sa_tofu.name
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = ["group:${module.grp_tofu_impersonators.id}"]
}

# give role vpc admin to the tofu service account
resource "google_project_iam_member" "sa_tofu_vpc_admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# give project permission to create gke clusters
resource "google_project_iam_member" "sa_tofu_gke_admin" {
  project = var.project
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# give role for creating service account iam.serviceAccounts.create on the project
resource "google_project_iam_member" "sa_tofu_create_sa" {
  project = var.project
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# allow the tofu service account in this project the role roles/container.defaultNodeServiceAccount
resource "google_project_iam_member" "sa_tofu_default_node_service_account" {
  project = var.project
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# allow on project iam.serviceAccountUser for tofu service account
resource "google_project_iam_member" "sa_tofu_iam_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# allow retrieving IAM policy for project for tofu service account
resource "google_project_iam_member" "sa_tofu_get_iam_policy" {
  project = var.project
  role    = "roles/iam.securityAdmin"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}

# allow sa tofu to create CRD in the gke cluster
resource "google_project_iam_member" "sa_tofu_crd" {
  project = var.project
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${google_service_account.sa_tofu.email}"
}