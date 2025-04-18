/**
 * Provide the needed roles for terragrunt group to access the terragrunt state bucket
 *
 * Created April 18th, 2025
 * @ywarezk
 */

dependency "admin_group" {
  config_path = "../../groups/terragrunt"
}

terraform {
  source = "./main.tf"
}

inputs = {
  terragrunt_group = dependency.admin_group.outputs.id
}

