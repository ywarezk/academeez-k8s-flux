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

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `parent` | yes | — | Parent folder or organization (`folders/<folder_id>` or `organizations/<org_id>`). |
| `names` | yes | — | Folder display names to create under the parent. |
| `prefix` | no | `""` | Optional prefix prepended to each folder name (with a trailing `-` when non-empty). |
| `deletion_protection` | no | `true` | Prevent Terraform from destroying or recreating the folder. |
| `set_roles` | no | `false` | Enable IAM role assignment via the folder admin variables below. |
| `per_folder_admins` | no | `{}` | IAM members (and optional roles) per folder name when `set_roles` is enabled. |
| `all_folder_admins` | no | `[]` | IAM members granted extended permissions on every folder when `set_roles` is enabled. |
| `folder_admin_roles` | no | See below | Roles applied when `set_roles` is enabled and roles are not set in `per_folder_admins`. |

Default for `folder_admin_roles` when omitted: `roles/owner`, `roles/resourcemanager.folderViewer`, `roles/resourcemanager.projectCreator`, `roles/compute.networkAdmin`.

After scaffolding, wire the unit into your live repository and supply org- or environment-specific configuration there.

In a stack `unit` block you only need to set the values you care about; optional keys use the `try()` defaults in the catalog unit. Required keys such as `parent` and `names` can be omitted from `values` when you supply them via an `autoinclude` `inputs` block instead (see [catalog units README](../README.md)).

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
| `parent` | `string` | The resource name of the parent Folder or Organization. Must be of the form `folders/<folder_id>` or `organizations/<org_id>`. |
| `names` | `list(string)` | Folder names. (Module default is `[]`; this unit expects at least one name when creating folders.) |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `prefix` | `string` | `""` | Optional prefix to enforce uniqueness of folder names. |
| `deletion_protection` | `bool` | `true` | Prevent Terraform from destroying or recreating the folder. |
| `set_roles` | `bool` | `false` | Enable setting roles via the folder admin variables. |
| `per_folder_admins` | `map(object)` | `{}` | IAM-style roles per members per folder who will get extended permissions. If roles are not provided for a folder/member combination, the list provided as `folder_admin_roles` will be applied as default. |
| `all_folder_admins` | `list(string)` | `[]` | List of IAM-style members that will get the extended permissions across all the folders. |
| `folder_admin_roles` | `list(string)` | `roles/owner`, `roles/resourcemanager.folderViewer`, `roles/resourcemanager.projectCreator`, `roles/compute.networkAdmin` | List of roles that will be applied to a folder if roles are not explicitly specified in `per_folder_admins`. |

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
