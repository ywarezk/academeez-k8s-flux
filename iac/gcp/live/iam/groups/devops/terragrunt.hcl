

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "group" {
  path = "${get_repo_root()}/iac/gcp/catalog/units/group/terragrunt.hcl"
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

inputs = {
  customer_id  = include.root.locals.customer_id
  owners       = [dependency.iam_sa.outputs.email]
  id           = "k8s-flux-devops@academeez.com"
  display_name = "k8s-flux-devops"
  description  = "k8s flux devops group"
  members      = ["k8s-flux@academeez.com"]
}
