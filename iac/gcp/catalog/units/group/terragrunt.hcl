/**
 * Google Cloud group unit.
 *
 * Wraps terraform-google-modules/group/google.
 * Consumers pass module inputs via the `inputs` block in live terragrunt.hcl,
 * or via `terragrunt.values.hcl` when scaffolding from the catalog (`values.*`).
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///terraform-google-modules/group/google?version=0.8.0"
}

inputs = merge(
  {
    domain               = try(values.domain, "")
    display_name         = try(values.display_name, "")
    description          = try(values.description, "")
    owners               = try(values.owners, [])
    managers             = try(values.managers, [])
    members              = try(values.members, [])
    initial_group_config = try(values.initial_group_config, "EMPTY")
    types                = try(values.types, ["default"])
  },
  try(values.id, "") != "" ? { id = values.id } : {},
  try(values.customer_id, "") != "" ? { customer_id = values.customer_id } : {},
)
