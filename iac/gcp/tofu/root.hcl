/**
 * The root terragrunt will contain:
 *    - common provider configurations
 *    - remote state configuration
 *    - impersonation logic
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

locals {
  region_vars     = yamldecode(file(find_in_parent_folders("region_vars.yaml")))
  billing_vars    = yamldecode(file(find_in_parent_folders("billing_vars.yaml")))
  common_vars     = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  iam             = try(yamldecode(file(find_in_parent_folders("iam.yaml"))), { "email" : "" })
  region          = local.region_vars.region
  billing_project = local.billing_vars.billing_project
  common_project  = local.common_vars.common_project
}

# configure remote state in bucket
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    project  = local.common_project
    location = "eu"
    bucket   = "academeez-k8s-flux-terragrunt-state"
    prefix   = "${path_relative_to_include()}/tofu.tfstate"
  }
}

# configure common providers
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
%{if length(local.iam.email) > 0}
# impersonate the service account
provider "google" {
  alias = "impersonation"
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonation
  target_service_account = "${local.iam.email}"
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
}

provider "google" {
  region  = "${local.region}"
  billing_project = "${local.billing_project}"
  user_project_override = true
  access_token = data.google_service_account_access_token.default.access_token
}

provider "google-beta" {
  region  = "${local.region}"
  billing_project = "${local.billing_project}"
  user_project_override = true
  access_token = data.google_service_account_access_token.default.access_token
}

%{else}
# authenticate as a user for fallback
provider "google" {	
	region  = "${local.region}"
	billing_project = "${local.billing_project}"
	user_project_override = true
}

provider "google-beta" {
  region  = "${local.region}"
  billing_project = "${local.billing_project}"
  user_project_override = true
}
%{endif}



EOF
}
 