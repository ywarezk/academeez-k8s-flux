<!-- Frontmatter
name: GCP Project IAM
description: Manage IAM role bindings on Google Cloud projects.
tags:
  - unit
  - gcp
  - google
  - iam
  - project
-->

# GCP Project IAM

Manages IAM bindings on one or more Google Cloud projects.

This is a **Unit** component. It wraps the [terraform-google-modules/iam/google//modules/projects_iam](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/projects_iam) submodule (v8.1.0).

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place.

After scaffolding, wire the unit into your live repository and supply environment-specific configuration there.

## Consumption

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "iam_project" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/catalog/units/iam/project?ref=v0.0.2"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

inputs = {
  projects = [include.root.locals.billing_project]
  mode     = "additive"
  bindings = {
    "roles/serviceusage.serviceUsageConsumer" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}
```

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `projects` | `list(string)` | Project IDs to bind roles on. |
| `bindings` | `map(list(string))` | Map of role → list of members. |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `mode` | `string` | `"additive"` | `additive` merges bindings; `authoritative` replaces bindings for listed roles. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/projects_iam?tab=inputs) for the full list.
