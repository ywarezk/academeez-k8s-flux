/**
 * this will create the iam service account
 * This service account is in charge of creating the groups and service accounts, and permissions of those groups and service accounts
 *
 * Created April 18th, 2025
 * @ywarezk
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "iam_sa" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/../catalog/units/service-account/terragrunt.hcl"
}


# iam project
dependency "iam_project" {
  config_path = "../../project"
}

inputs = {
  names      = ["iam"]
  project_id = dependency.iam_project.outputs.project_id
}