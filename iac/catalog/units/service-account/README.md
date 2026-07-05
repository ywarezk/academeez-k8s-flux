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

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and generates a `terragrunt.values.hcl` for any `values.*` references collected by the form.

After scaffolding, wire the unit into your live repository and supply project-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "service_account" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/catalog/units/service-account?ref=<version>"
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
| `project_id` | `string` | The GCP project ID where service accounts are created. |
| `names` | `list(string)` | Service account names (short names, not email addresses). |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `prefix` | `string` | `""` | Prefix prepended to service account IDs for uniqueness across projects. |
| `description` | `string` | `""` | Description applied to all created service accounts. |
| `display_name` | `string` | `""` | Display name applied to all created service accounts. |
| `project_roles` | `list(string)` | `[]` | Project-level IAM roles to grant to each service account. |
| `generate_keys` | `bool` | `false` | Whether to generate JSON keys for the service accounts. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest?tab=inputs) for the full list.

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

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/service-accounts/google/latest?tab=outputs) for the full list.
