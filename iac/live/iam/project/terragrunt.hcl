/**
 * this will create the iam project under the iam folder
 *
 * Created April 18th, 2025
 * @ywarezk
 */

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "project" {
  path = "${get_repo_root()}/iac/catalog/units/project/terragrunt.hcl"
}

dependency "iam_folder" {
  config_path = "../folder"
}

inputs = {
  folder_id         = dependency.iam_folder.outputs.id
  name              = "academeez-k8s-flux-iam"
  org_id            = include.root.locals.org_id
  billing_account   = include.root.locals.billing_account
  random_project_id = true
  budget_amount     = 20
}
