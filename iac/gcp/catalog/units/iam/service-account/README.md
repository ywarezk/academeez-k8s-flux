<!-- Frontmatter
name: GCP Service Account IAM
description: Manage IAM role bindings on Google Cloud service accounts.
tags:
  - unit
  - gcp
  - google
  - iam
  - service-account
-->

# GCP Service Account IAM

Manages IAM bindings on service accounts within a project.

This is a **Unit** component. It wraps the [terraform-google-modules/iam/google//modules/service_accounts_iam](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/service_accounts_iam) submodule (v8.1.0).

> **Note:** This unit grants IAM **on** service accounts. To **create** service accounts, use the [`service-account`](../../service-account/) catalog unit.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place.

After scaffolding, wire the unit into your live repository and supply environment-specific configuration there.

## Consumption

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "iam_service_account" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/iam/service-account?ref=v0.0.2"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

dependency "admin_group" {
  config_path = "../../../groups/admin"
}

dependency "project" {
  config_path = "../../../project"
}

inputs = {
  service_accounts = [dependency.iam_sa.outputs.email]
  project          = dependency.project.outputs.project_id
  mode             = "authoritative"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = [
      "group:${dependency.admin_group.outputs.id}"
    ]
  }
}
```

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `service_accounts` | `list(string)` | Service account emails to bind roles on. |
| `project` | `string` | Project ID containing the service accounts. |
| `bindings` | `map(list(string))` | Map of role → list of members. |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `mode` | `string` | `"additive"` | `additive` merges bindings; `authoritative` replaces bindings for listed roles. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/service_accounts_iam?tab=inputs) for the full list.
