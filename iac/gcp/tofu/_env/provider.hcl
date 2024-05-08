#
# Some operations require an admin service account impersonation to be used
# stuff like creating projects, giving permissions to the tofu service account of the course,
# this stuff can not be done with the tofu service account, it needs to be done with an admin service account
#
# Created May 8th, 2024
# @author ywarezk
# @license MIT
#

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  
  # this will allow us to switch region between dev/prod to save costs
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region   = local.region_vars.locals.region
  project  = local.common_vars.project
  provider_vars = read_terragrunt_config(find_in_parent_folders("sa_provider.hcl"))
}

# Generate a google provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
	
provider "google" {
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
	region = "${local.region}"
  project = "${local.project}"
}

#receive short-lived access token
data "google_service_account_access_token" "sa_impersonate" {
  provider               = google.impersonation
  target_service_account = "${local.provider_vars.locals.sa_provider}"
  scopes                 = ["cloud-platform", "userinfo-email"]
  lifetime               = "3600s"
}

# default provider to use the the token
provider "google" {
  project = "${local.project}"
  access_token    = data.google_service_account_access_token.sa_impersonate.access_token
  request_timeout = "60s"
}

provider "google-beta" {
  region = "${local.region}"
  project = "${local.project}"
  access_token    = data.google_service_account_access_token.sa_impersonate.access_token
  request_timeout = "60s"
}
EOF
}