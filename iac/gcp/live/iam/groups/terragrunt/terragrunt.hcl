/**
 * Google Cloud group unit.
 *
 * Wraps terraform-google-modules/group/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "tfr:///terraform-google-modules/group/google?version=0.8.0"
}

dependency "admin_group" {
  config_path = "../admin"
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

inputs = {
  id                   = values.id
  customer_id          = include.root.locals.customer_id
  domain               = try(values.domain, "")
  display_name         = try(values.display_name, "")
  description          = try(values.description, "")
  owners               = [dependency.iam_sa.outputs.email]
  managers             = try(values.managers, [])
  members              = [dependency.admin_group.outputs.id]
  initial_group_config = try(values.initial_group_config, "EMPTY")
  types                = try(values.types, ["default"])
}
