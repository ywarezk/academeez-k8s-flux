

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

dependency "admin_group" {
  config_path = "../../../groups/admin"
}

dependency "iam_project" {
  config_path = "../../../project"
}

include "sa_allow" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_modules/iam/service-account.hcl"
}

inputs = {
  service_accounts = [dependency.iam_sa.outputs.email]
  project          = dependency.iam_project.outputs.project_id
  mode             = "authoritative"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" : [
      "group:${dependency.admin_group.outputs.id}"
    ]
  }
}