<!-- Frontmatter
name: GCP Service Account
description: Create Google Cloud service accounts in a project.
tags:
  - unit
  - gcp
  - google
  - iam
  - service-account
-->

# GCP Service Account

Creates one or more service accounts in a Google Cloud project.

This is a **Unit** component. It wraps the [terraform-google-modules/service-accounts/google](https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google) module (v4.7.0).

> **Note:** This unit **creates** service accounts. To grant IAM **on** service accounts, use the [`iam/service-account`](../iam/service-account/) catalog unit.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `project_id` | yes | — | Project id where service account will be created. |
| `prefix` | no | `""` | Prefix applied to service account names. |
| `names` | no | `[]` | Names of the service accounts to create. |
| `project_roles` | no | `[]` | Common roles to apply to all service accounts (`project=>role` as elements). |
| `grant_billing_role` | no | `false` | Grant billing user role. |
| `billing_account_id` | no | `""` | Billing account when assigning billing role (default is org-level). |
| `grant_xpn_roles` | no | `true` | Grant roles for shared VPC management. |
| `org_id` | no | `""` | Id of the organization for org-level roles. |
| `generate_keys` | no | `false` | Generate keys for service accounts. |
| `display_name` | no | `"Terraform-managed service account"` | Display names of the created service accounts. |
| `description` | no | `""` | Default description of the created service accounts. |
| `descriptions` | no | `[]` | Per-account descriptions (default to `description`). |
| `disabled` | no | `{}` | Map of service account name → disabled flag. |

Set `names` together with `project_id` when scaffolding a real service account.

After scaffolding, wire the unit into your live repository and supply project-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "service_account" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/service-account?ref=<version>"
}

dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id = dependency.project.outputs.project_id
  names      = ["my-sa"]
  prefix     = "my-org"
}
```

Project-specific values (`project_id`, `names`, `prefix`) belong in the **live** repository, not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `project_id` | `string` | Project id where service account will be created. |

## Commonly set in live

| Input | Notes |
|-------|--------|
| `names` | Short account names (not email addresses). |
| `prefix` | Often used for uniqueness across projects (e.g. org slug). |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `prefix` | `string` | `""` | Prefix applied to service account names. |
| `names` | `list(string)` | `[]` | Names of the service accounts to create. |
| `project_roles` | `list(string)` | `[]` | Common roles to apply to all service accounts, `project=>role` as elements. |
| `grant_billing_role` | `bool` | `false` | Grant billing user role. |
| `billing_account_id` | `string` | `""` | If assigning billing role, specify a billing account (default is org-level). |
| `grant_xpn_roles` | `bool` | `true` | Grant roles for shared VPC management. |
| `org_id` | `string` | `""` | Id of the organization for org-level roles. |
| `generate_keys` | `bool` | `false` | Generate keys for service accounts. |
| `display_name` | `string` | `"Terraform-managed service account"` | Display names of the created service accounts. |
| `description` | `string` | `""` | Default description of the created service accounts. |
| `descriptions` | `list(string)` | `[]` | List of descriptions per account (elements default to `description`). |
| `disabled` | `map(bool)` | `{}` | Map of service account names to disabled flag; omitted names stay enabled. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/4.7.0?tab=inputs) for the full list.

## Examples

### Service account in a project

```hcl
dependency "iam_project" {
  config_path = "../../project"
}

inputs = {
  project_id = dependency.iam_project.outputs.project_id
  names      = ["automation"]
  prefix     = "platform"
}
```

### Service account with project roles

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id    = dependency.project.outputs.project_id
  names         = ["deployer"]
  prefix        = "my-org"
  project_roles = ["roles/storage.objectViewer"]
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `email` | Service account email address. |
| `iam_email` | Map of service account name to IAM-style email (`serviceAccount:...`). |
| `service_account` | Map of service account name to resource attributes. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/4.7.0?tab=outputs) for the full list.
