#
# Bootstrap flux on the cluster
#
# Created May 13th, 2024
# @author ywarezk
# @license MIT
#

locals {
	common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  env = basename(dirname(get_terragrunt_dir()))
}

terraform {
  source = "${dirname(find_in_parent_folders())}/_env/flux/main.tf"
}

dependency "gke" {
	config_path = "${dirname(find_in_parent_folders())}/${local.env}/gke"
}

generate "provider_flux" {
	path      = "provider_flux.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
	
provider "flux" {
	kubernetes = {		
		exec = {
			api_version = "client.authentication.k8s.io/v1beta1"
			args        = []
			command     = "gke-gcloud-auth-plugin"
		}
    host                   = "https://${dependency.gke.outputs.gke.endpoint}"        
    cluster_ca_certificate = <<EOT
${base64decode(dependency.gke.outputs.gke.ca_certificate)}
EOT    
  }
  git = {
    url = "https://github.com/${local.common_vars.github_org}/${local.common_vars.github_repository}.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = "${local.common_vars.github_token}"
    }
  }
}

provider "github" {
  owner = "${local.common_vars.github_org}"
  token = "${local.common_vars.github_token}"
}
EOF
}

inputs = {
	env = local.env	
}