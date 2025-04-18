/**
 * This will create the permissions and roles that we give the iam service account
 *
 * Created April 18th, 2025
 * @ywarezk
 */

locals {
  billing_vars = yamldecode(file(find_in_parent_folders("billing_vars.yaml")))
}

include "root" {
  path = find_in_parent_folders()
}

dependency "iam_project" {
  config_path = "../../project"
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

dependency "root_folder" {
  config_path = "../../../common/folders/root"
}

dependency "admin_group" {
  config_path = "../../groups/admin"
}

terraform {
  source = "./main.tf"
}

inputs = {
  iam_project     = dependency.iam_project.outputs.project_id
  iam_sa          = dependency.iam_sa.outputs.email
  iam_sa_name     = dependency.iam_sa.outputs.service_account.name
  root_folder     = dependency.root_folder.outputs.id
  billing_project = local.billing_vars.billing_project
  admin_group     = dependency.admin_group.outputs.id
}