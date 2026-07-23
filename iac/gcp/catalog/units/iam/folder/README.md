<!-- Frontmatter
name: GCP Folder IAM
description: Manage IAM role bindings on Google Cloud folders.
tags:
  - unit
  - gcp
  - google
  - iam
  - folder
-->

# GCP Folder IAM

Manages IAM bindings on one or more Google Cloud folders.

This is a **Unit** component. It wraps the [terraform-google-modules/iam/google//modules/folders_iam](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/folders_iam) submodule (v8.1.0).

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place.

After scaffolding, wire the unit into your live repository and supply environment-specific configuration there.

## Consumption

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "iam_folder" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/iam/folder?ref=v0.0.2"
}

dependency "folder" {
  config_path = "../../../../common/folders/root"
}

dependency "iam_sa" {
  config_path = "../../../service-accounts/iam"
}

inputs = {
  folders = [dependency.folder.outputs.id]
  mode    = "authoritative"
  bindings = {
    "roles/resourcemanager.folderViewer" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}
```

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `folders` | `list(string)` | Folder IDs or `folders/{id}` values to bind roles on. |
| `bindings` | `map(list(string))` | Map of role → list of members (`user:`, `group:`, `serviceAccount:`). |

## Commonly used optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `mode` | `string` | `"additive"` | `additive` merges bindings; `authoritative` replaces bindings for listed roles. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/iam/google/latest/submodules/folders_iam?tab=inputs) for the full list.
