<!-- Frontmatter
name: GCP Storage Bucket IAM
description: Manage IAM role bindings on Google Cloud Storage buckets.
tags:
  - unit
  - gcp
  - google
  - iam
  - storage
-->

# GCP Storage Bucket IAM

Manages IAM bindings on one or more Google Cloud Storage buckets.

This is a **Unit** component. It wraps the [terraform-google-modules/iam/google//modules/storage_buckets_iam](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/storage_buckets_iam) submodule (v8.1.0).

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place.

After scaffolding, wire the unit into your live repository and supply environment-specific configuration there.

## Consumption

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "iam_storage_bucket" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/iam/storage-bucket?ref=v0.0.2"
}

dependency "operators_group" {
  config_path = "../../../groups/terragrunt"
}

inputs = {
  storage_buckets = ["my-terragrunt-state-bucket"]
  mode            = "additive"
  bindings = {
    "roles/storage.admin" = [
      "group:${dependency.operators_group.outputs.id}"
    ]
  }
}
```

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `storage_buckets` | `list(string)` | Storage bucket names to bind roles on. |
| `bindings` | `map(list(string))` | Map of role → list of members. |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `mode` | `string` | `"additive"` | `additive` merges bindings; `authoritative` replaces bindings for listed roles. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/storage_buckets_iam?tab=inputs) for the full list.
