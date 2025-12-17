

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "devops_sa" {
  config_path = "../../../service-accounts/devops"
}

dependency "devops_group" {
  config_path = "../../../groups/devops"
}

dependency "iam_project" {
  config_path = "../../../project"
}

include "sa_allow" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_modules/iam/service-account.hcl"
}

inputs = {
  service_accounts = [dependency.devops_sa.outputs.email]
  project          = dependency.iam_project.outputs.project_id
  mode             = "authoritative"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" : [
      "group:${dependency.devops_group.outputs.id}"
    ]
  }
}