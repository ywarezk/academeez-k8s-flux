#
# permissions that give to the iam project
# permission to generate service accounts inside the iam project
#

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "devops_sa" {
  config_path = "../../../service-accounts/devops"
}

include "iam" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/iam/billing-account/terragrunt.hcl"
}

inputs = {
  billing_account_ids = [include.root.locals.billing_account]
  mode                = "additive"
  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${dependency.devops_sa.outputs.email}"
    ]
  }
}
