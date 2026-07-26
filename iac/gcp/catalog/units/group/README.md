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

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `id` | yes | — | Group email address (Google-managed group ID). |
| `customer_id` | yes* | — | Google Workspace customer ID (`config/common.hcl` in live). |
| `domain` | no | `""` | Workspace domain instead of `customer_id` (set one or the other). |
| `display_name` | no | `""` | Display name of the group. |
| `description` | no | `""` | Description of the group. |
| `owners` | no | `[]` | Owner emails (users, groups, or service accounts). |
| `managers` | no | `[]` | Manager emails. |
| `members` | no | `[]` | Member emails. |
| `initial_group_config` | no | `"EMPTY"` | Initial group config (`WITH_INITIAL_OWNER`, `EMPTY`, etc.). |
| `types` | no | `["default"]` | Group types (`default`, `dynamic`, `security`, `external`). |

\*Module requires **either** `customer_id` or `domain`. This catalog unit prompts for `customer_id` by default; use `domain` when you do not use a customer ID.

After scaffolding, wire the unit into your live repository and supply workspace- and org-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "group" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/group?ref=v0.0.2"
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
| `id` | `string` | ID of the group. For Google-managed entities, the ID must be the email address of the group. |
| `customer_id` | `string` | Customer ID of the organization to create the group in. One of `domain` or `customer_id` must be specified. |
| `domain` | `string` | Domain of the organization to create the group in. One of `domain` or `customer_id` must be specified. Default `""`. |

When scaffolding, provide `customer_id` **or** set `domain` (leave the other at its default).

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `display_name` | `string` | `""` | Display name of the group. |
| `description` | `string` | `""` | Description of the group. |
| `owners` | `list(string)` | `[]` | Owners of the group. Each entry is the email address of an existing group, user, or service account. |
| `managers` | `list(string)` | `[]` | Managers of the group. Each entry is the email address of an existing group, user, or service account. |
| `members` | `list(string)` | `[]` | Members of the group. Each entry is the email address of an existing group, user, or service account. |
| `initial_group_config` | `string` | `"EMPTY"` | Initial configuration when creating a group (`INITIAL_GROUP_CONFIG_UNSPECIFIED`, `WITH_INITIAL_OWNER`, `EMPTY`). |
| `types` | `list(string)` | `["default"]` | Group types. Valid values: `default`, `dynamic`, `security`, `external`. |

## Commonly used optional inputs

The following are the fields most live configurations set in addition to `customer_id` and `id`:

| Input | Type | Notes |
|-------|------|--------|
| `owners` | `list(string)` | Often a service account from a `dependency`. |
| `members` | `list(string)` | User or group emails. |
| `display_name` | `string` | Short name shown in Workspace admin. |
| `description` | `string` | Free-text group description. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/group/google/0.8.0?tab=inputs) for the full list.

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
