/**
 * The common resources that are shared between the environments will be under the common project
 *
 * Created December 15th, 2024
 * @author ywarezk
 */

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "project" {
  path = "${get_repo_root()}/iac/catalog/units/project/terragrunt.hcl"
}

dependency "shared_folder" {
  config_path = "../folders/shared"
}

inputs = {
  folder_id         = dependency.shared_folder.outputs.id
  name              = "academeez-k8s-flux-common"
  org_id            = include.root.locals.org_id
  billing_account   = include.root.locals.billing_account
  random_project_id = true
  budget_amount     = 20
}
