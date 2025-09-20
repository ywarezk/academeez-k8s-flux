# 
# permissions that give to the iam project
# permission to generate service accounts inside the iam project 
# 

locals {
  billing_vars    = yamldecode(file(find_in_parent_folders("billing_vars.yaml")))
  billing_project = local.billing_vars.billing_project
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}


dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

include "iam" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_env/iam/project.hcl"
}

inputs = {
  projects = [local.billing_project]
  mode     = "additive"
  bindings = {
    "roles/serviceusage.serviceUsageConsumer" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ],
    "roles/iam.securityAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}