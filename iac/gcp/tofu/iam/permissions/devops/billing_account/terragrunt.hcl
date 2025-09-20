# 
# permissions that give to the iam project
# permission to generate service accounts inside the iam project 
# 

locals {
  billing_vars    = yamldecode(file(find_in_parent_folders("billing_vars.yaml")))
  billing_account = local.billing_vars.billing_account
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}


dependency "devops_sa" {
  config_path = "../../../service-accounts/devops"
}

include "iam" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_env/iam/billing-account.hcl"
}

inputs = {
  billing_account_ids = [local.billing_account]
  mode                = "additive"
  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${dependency.devops_sa.outputs.email}"
    ]
  }
}