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
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/iam/project/terragrunt.hcl"
}

inputs = {
  projects = [include.root.locals.billing_project]
  mode     = "additive"
  bindings = {
    "roles/serviceusage.serviceUsageConsumer" = [
      "serviceAccount:${dependency.devops_sa.outputs.email}"
    ]
  }
}
