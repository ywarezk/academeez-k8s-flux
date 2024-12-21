/**
 * terragrunt function to create a folder
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

locals {
  org_id = yamldecode(file(find_in_parent_folders("common_vars.yaml"))).org_id
}

terraform {
  source = "tfr:///terraform-google-modules/folders/google?version=5.0.0"
}

inputs = {
  parent = "organizations/${local.org_id}"
}