<!-- Frontmatter
name: GCP Group
description: Create a Google Workspace group for Cloud IAM and organization management.
tags:
  - unit
  - gcp
  - google
  - iam
  - group
-->

# GCP Group

Creates a Google Workspace group using the [terraform-google-modules/group/google](https://registry.terraform.io/modules/terraform-google-modules/group/google) module (v0.8.0).

This is a **Unit** component. It is typically used to manage group membership and ownership for GCP organization workflows.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and generates a `terragrunt.values.hcl` for any `values.*` references collected by the form.

After scaffolding, wire the unit into your live repository and supply workspace- and org-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "group" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/catalog/units/group?ref=v0.0.2"
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

inputs = {
  customer_id  = include.root.locals.customer_id
  owners       = [dependency.iam_sa.outputs.email]
  id           = "my-group@example.com"
  display_name = "My Group"
  description  = "Example group"
  members      = ["user@example.com"]
}
```

`customer_id` belongs in the **live** repository (`root.hcl` from `config/common.hcl`). Group identity (`id`, `members`, `owners`) is always live-specific.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `customer_id` | `string` | Google Workspace customer ID. |
| `id` | `string` | Group email address (e.g. `team@example.com`). |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `owners` | `list(string)` | `[]` | Group owners (user or service account emails). |
| `managers` | `list(string)` | `[]` | Group managers. |
| `members` | `list(string)` | `[]` | Group members. |
| `display_name` | `string` | `""` | Display name for the group. |
| `description` | `string` | `""` | Group description. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/group/google/latest?tab=inputs) for the full list.

## Examples

### Admin group owned by an IAM service account

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

inputs = {
  customer_id  = include.root.locals.customer_id
  owners       = [dependency.iam_sa.outputs.email]
  id           = "platform-admin@example.com"
  display_name = "Platform Admin"
  members      = ["ops@example.com"]
}
```

### Group with another group as a member

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "iam_sa" {
  config_path = "../../service-accounts/iam"
}

dependency "parent_group" {
  config_path = "../admin"
}

inputs = {
  customer_id  = include.root.locals.customer_id
  owners       = [dependency.iam_sa.outputs.email]
  id           = "platform-terragrunt@example.com"
  display_name = "Terragrunt Operators"
  members      = [dependency.parent_group.outputs.id]
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `id` | Group email address. |
| `name` | Group resource name. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/group/google/latest?tab=outputs) for the full list.
