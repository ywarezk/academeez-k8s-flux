# 
# permissions that give to the iam project
# permission to generate service accounts inside the iam project 
# 

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "iam_project" {
  config_path = "../../../project"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

include "iam" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_env/iam/project.hcl"
}

inputs = {
  projects = [dependency.iam_project.outputs.project_id]
  mode     = "authoritative"
  bindings = {
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}