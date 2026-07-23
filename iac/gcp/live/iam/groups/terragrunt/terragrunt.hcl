

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "group" {
  path = "${get_repo_root()}/iac/gcp/catalog/units/group/terragrunt.hcl"
}

dependency "admin_group" {
  config_path = "../admin"
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

inputs = {
  customer_id  = include.root.locals.customer_id
  owners       = [dependency.iam_sa.outputs.email]
  id           = "k8s-flux-terragrunt@academeez.com"
  display_name = "k8s-flux-terragrunt"
  description  = "k8s flux terragrunt bucket"
  members      = [dependency.admin_group.outputs.id]
}
