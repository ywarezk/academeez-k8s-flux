/**
 * - common providers configuration
 * - remote state configuration
 */
 
locals {
	region_vars = yamldecode(file(find_in_parent_folders("region_vars.yaml")))
	billing_vars = yamldecode(file(find_in_parent_folders("billing_vars.yaml")))
	common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
	region = local.region_vars.region
	billing_project = local.billing_vars.billing_project
	common_project = local.common_vars.common_project
}
 
remote_state {
  backend = "gcs"

	generate = {
		path = "backend.tf"
		if_exists = "overwrite"		
	}

  config = {
    project  = local.common_project
    location = "eu"
    bucket   = "academeez-k8s-flux-terragrunt-state"
    prefix   = "${path_relative_to_include()}/tofu.tfstate"
  }
}
 
generate "provider" {
	path = "provider.tf"
	if_exists = "overwrite"
	contents = <<EOF
provider "google" {	
	region  = "${local.region}"
	billing_project = "${local.billing_project}"
	user_project_override = true
}
EOF
}
	
	