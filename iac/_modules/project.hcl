/**
 * terragrunt function to create a project
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

locals {
  org_id          = yamldecode(file(find_in_parent_folders("common_vars.yaml"))).org_id
  billing_account = yamldecode(file(find_in_parent_folders("billing_vars.yaml"))).billing_account
}

terraform {
  source = "tfr:///terraform-google-modules/project-factory/google?version=17.1.0"
}

inputs = {
  random_project_id = true
  org_id            = local.org_id
  billing_account   = local.billing_account
  budget_amount     = 20
}