<!-- Frontmatter
name: GCP Billing Account IAM
description: Manage IAM role bindings on Google Cloud billing accounts.
tags:
  - unit
  - gcp
  - google
  - iam
  - billing
-->

# GCP Billing Account IAM

Manages IAM bindings on one or more Google Cloud billing accounts.

This is a **Unit** component. It wraps the [terraform-google-modules/iam/google//modules/billing_accounts_iam](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/billing_accounts_iam) submodule (v8.1.0).

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place.

After scaffolding, wire the unit into your live repository and supply environment-specific configuration there.

## Consumption

```hcl
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "iam_billing_account" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/catalog/units/iam/billing-account?ref=v0.0.2"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

inputs = {
  billing_account_ids = [include.root.locals.billing_account]
  mode                = "additive"
  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}
```

Billing account IDs belong in the **live** repository (`root.hcl` from `billing_vars.yaml`).

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `billing_account_ids` | `list(string)` | Billing account IDs to bind roles on. |
| `bindings` | `map(list(string))` | Map of role → list of members. |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `mode` | `string` | `"additive"` | `additive` merges bindings; `authoritative` replaces bindings for listed roles. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/billing_accounts_iam?tab=inputs) for the full list.
