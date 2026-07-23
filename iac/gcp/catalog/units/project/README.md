<!-- Frontmatter
name: GCP Project
description: Create a Google Cloud project with project-factory best practices.
tags:
  - unit
  - gcp
  - google
  - project
-->

# GCP Project

Creates a Google Cloud project using the [terraform-google-modules/project-factory/google](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google) module (v18.3.0).

This is a **Unit** component. It provisions a project, attaches billing, enables APIs, and applies opinionated defaults from the upstream module.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and generates a `terragrunt.values.hcl` for any `values.*` references collected by the form.

After scaffolding, wire the unit into your live repository and supply org- or environment-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "project" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/project?ref=<version>"
}

dependency "parent_folder" {
  config_path = "../folders/shared"
}

inputs = {
  folder_id         = dependency.parent_folder.outputs.id
  name              = "my-project"
  org_id            = include.root.locals.org_id
  billing_account   = include.root.locals.billing_account
  random_project_id = true
}
```

Org- and billing-specific values belong in the **live** repository (`root.hcl`), not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `name` | `string` | Display name for the project. |
| `billing_account` | `string` | Billing account ID to attach to the project. |

You must also set **either** `folder_id` (project under a folder) **or** `org_id` (project under an organization). In practice, most live configs pass both when the folder lives under an org.

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `folder_id` | `string` | `""` | Folder ID to host the project. |
| `org_id` | `string` | `null` | Organization ID (often supplied from live `root.hcl`). |
| `random_project_id` | `bool` | `false` | Append a random suffix to the project ID for global uniqueness. |
| `project_id` | `string` | `""` | Explicit project ID; if unset, derived from `name`. |
| `activate_apis` | `list(string)` | `["compute.googleapis.com"]` | APIs to enable on the project. |
| `budget_amount` | `number` | `null` | Budget alert amount; omit to skip budget creation. |
| `labels` | `map(string)` | `{}` | Labels to apply to the project. |
| `deletion_policy` | `string` | `"PREVENT"` | `DELETE` or `PREVENT` to control accidental project deletion. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest?tab=inputs) for the full list.

## Examples

### Project under a folder

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "shared_folder" {
  config_path = "../folders/shared"
}

inputs = {
  folder_id         = dependency.shared_folder.outputs.id
  name              = "platform-common"
  org_id            = include.root.locals.org_id
  billing_account   = include.root.locals.billing_account
  random_project_id = true
}
```

### Project with a budget alert

Set `budget_amount` explicitly in live when you want billing alerts — the catalog does not impose a default:

```hcl
inputs = {
  folder_id         = dependency.parent_folder.outputs.id
  name              = "platform-dev"
  org_id            = include.root.locals.org_id
  billing_account   = include.root.locals.billing_account
  random_project_id = true
  budget_amount     = 50
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `project_id` | The created project ID. |
| `project_number` | The project number. |
| `project_name` | The project name. |
| `service_account_email` | Default project service account email (if created). |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest?tab=outputs) for the full list.
