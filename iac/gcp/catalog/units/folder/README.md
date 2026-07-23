<!-- Frontmatter
name: GCP Folder
description: Create Google Cloud folders under an organization or parent folder.
tags:
  - unit
  - gcp
  - google
  - folder
-->

# GCP Folder

Creates one or more Google Cloud folders under a parent organization or folder.

This is a **Unit** component. It wraps the [terraform-google-modules/folders/google](https://registry.terraform.io/modules/terraform-google-modules/folders/google) module (v5.1.0).

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and generates a `terragrunt.values.hcl` for any `values.*` references collected by the form.

After scaffolding, wire the unit into your live repository and supply org- or environment-specific configuration there.

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "folder" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/folder?ref=v0.0.2"
}

inputs = {
  parent = "organizations/<org_id>"
  names  = ["my-folder"]
}
```

Org- or account-specific values (such as `org_id`) belong in the **live** repository, not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `parent` | `string` | Parent resource. Must be `organizations/<org_id>` or `folders/<folder_id>`. |
| `names` | `list(string)` | Folder names to create under the parent. |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `prefix` | `string` | `""` | Optional prefix prepended to folder names. |
| `deletion_protection` | `bool` | `true` | Prevent Terraform from destroying or recreating the folder. |
| `set_roles` | `bool` | `false` | Enable IAM role assignment via the admin variables below. |
| `folder_admin_roles` | `list(string)` | See module docs | Default roles applied when `set_roles` is enabled. |
| `per_folder_admins` | `map(object)` | `{}` | IAM members and roles per folder name. |
| `all_folder_admins` | `list(string)` | `[]` | IAM members granted extended permissions on all folders. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/folders/google/latest?tab=inputs) for full details.

## Examples

### Root folder under an organization

```hcl
locals {
  common  = read_terragrunt_config(find_in_parent_folders("config/common.hcl")).locals
  org_id  = local.common.org_id
}

inputs = {
  parent = "organizations/${local.org_id}"
  names  = ["platform"]
}
```

### Nested folder under another folder

Use a `dependency` block in live to pass the parent folder ID:

```hcl
dependency "parent_folder" {
  config_path = "../root"
}

inputs = {
  parent = dependency.parent_folder.outputs.id
  names  = ["shared"]
}
```

### Folder with deletion protection disabled

```hcl
inputs = {
  parent              = dependency.parent_folder.outputs.id
  names               = ["sandbox"]
  deletion_protection = false
}
```

## Outputs

This module exposes folder IDs and names. Common outputs:

| Output | Description |
|--------|-------------|
| `id` | Folder id (string) for single-folder use (e.g. `folders/12345`). |
| `ids` | Map of folder name to folder id. |
| `folder` | Folder resource (object) for single-folder use. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/folders/google/latest?tab=outputs) for the full list.
