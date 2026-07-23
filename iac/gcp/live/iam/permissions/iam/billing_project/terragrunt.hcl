#
# permissions that give to the iam project
# permission to generate service accounts inside the iam project
#

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

include "iam" {
  path = "${get_repo_root()}/iac/gcp/catalog/units/iam/project/terragrunt.hcl"
}

inputs = {
  projects = [include.root.locals.billing_project]
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
