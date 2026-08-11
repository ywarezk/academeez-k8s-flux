<!-- Frontmatter
name: GCP Storage Bucket
description: Create Google Cloud Storage buckets in a project.
tags:
  - unit
  - gcp
  - google
  - storage
  - bucket
-->

# GCP Storage Bucket

Creates one or more Google Cloud Storage buckets in a project.

This is a **Unit** component. It wraps the [terraform-google-modules/cloud-storage/google](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google) module (v12.3.0).

> **Note:** This unit **creates** buckets. To manage IAM **on** existing buckets, use the [`iam/storage-bucket`](../iam/storage-bucket/) catalog unit.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `project_id` | yes | — | Project ID where buckets will be created. |
| `names` | yes | — | Bucket name suffixes (combined with `prefix` to form the full bucket name). |
| `prefix` | no | `""` | Prefix used to generate globally unique bucket names. |
| `location` | no | `"EU"` | Bucket location (region or multi-region). |
| `storage_class` | no | `"STANDARD"` | Bucket storage class. |
| `randomize_suffix` | no | `false` | Add a randomized 4-character suffix to all bucket names. |
| `labels` | no | `{}` | Labels attached to all buckets. |
| `public_access_prevention` | no | `"inherited"` | Public access prevention (`inherited` or `enforced`). |
| `versioning` | no | `{}` | Map of bucket name suffix => enable versioning. |
| `force_destroy` | no | `{}` | Map of bucket name suffix => allow force destroy. |
| `bucket_policy_only` | no | `{}` | Map of bucket name suffix => uniform bucket-level access (defaults to `true` per bucket when set). |

Set `project_id` and `names` together when scaffolding a real bucket.

After scaffolding, wire the unit into your live repository and supply project-specific configuration there.

In a stack `unit` block you only need to set the values you care about; optional keys use the `try()` defaults in the catalog unit. Required keys such as `project_id` and `names` can be omitted from `values` when you supply them via an `autoinclude` `inputs` block instead (see [catalog units README](../README.md)).

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "storage_bucket" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/storage-bucket?ref=<version>"
}

dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id = dependency.project.outputs.project_id
  names      = ["terragrunt-state"]
  prefix     = "academeez-k8s-flux"
  location   = "EU"
  versioning = {
    terragrunt-state = true
  }
}
```

Project-specific values (`project_id`, `names`, `prefix`, `location`) belong in the **live** repository, not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `project_id` | `string` | Project ID where buckets will be created. |
| `names` | `list(string)` | Bucket name suffixes. (Module default is `[]`; this unit expects at least one name when creating buckets.) |

## Commonly set in live

| Input | Notes |
|-------|--------|
| `prefix` | Often an org or environment slug for globally unique bucket names. |
| `location` | Region or multi-region (e.g. `EU`, `US`, `europe-west1`). |
| `versioning` | Enable versioning per bucket suffix (e.g. for state or backup buckets). |
| `force_destroy` | Set to `true` for ephemeral or sandbox buckets. |
| `public_access_prevention` | Use `enforced` for sensitive data. |
| `labels` | Environment or team labels for cost allocation. |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `prefix` | `string` | `""` | Prefix used to generate the bucket name. |
| `location` | `string` | `"EU"` | Bucket location. |
| `storage_class` | `string` | `"STANDARD"` | Bucket storage class. |
| `randomize_suffix` | `bool` | `false` | Adds an identical, but randomized 4-character suffix to all bucket names. |
| `labels` | `map(string)` | `{}` | Labels to be attached to the buckets. |
| `public_access_prevention` | `string` | `"inherited"` | Prevents public access to a bucket (`inherited` or `enforced`). |
| `versioning` | `map(bool)` | `{}` | Map of lowercase unprefixed name => boolean. |
| `autoclass` | `map(bool)` | `{}` | Map of bucket name suffix => enable Autoclass. |
| `bucket_policy_only` | `map(bool)` | `{}` | Disable ad-hoc ACLs on specified buckets (defaults to `true` when set). |
| `force_destroy` | `map(bool)` | `{}` | Map of bucket name suffix => allow Terraform to delete non-empty buckets. |
| `default_event_based_hold` | `map(bool)` | `{}` | Enable event-based hold on new objects per bucket. |
| `hierarchical_namespace` | `map(bool)` | `{}` | Enable hierarchical namespace per bucket. |
| `encryption_key_names` | `map(string)` | `{}` | Map of bucket name suffix => KMS key name. |
| `retention_policy` | `any` | `{}` | Map of retention policy values per bucket. |
| `soft_delete_policy` | `map(any)` | `{}` | Soft delete policies per bucket. |
| `logging` | `any` | `{}` | Access logging configuration per bucket. |
| `website` | `object` | `{}` | Website configuration (`main_page_suffix`, `not_found_page`). |
| `custom_placement_config` | `any` | `{}` | Custom dual-region placement config per bucket. |
| `folders` | `map(list(string))` | `{}` | Map of bucket name suffix => list of top-level folder objects to create. |
| `lifecycle_rules` | `set(object)` | `[]` | Lifecycle rules applied to all buckets. |
| `bucket_lifecycle_rules` | `map(set(object))` | `{}` | Per-bucket lifecycle rules. |
| `cors` | `list(object)` | `[]` | CORS configuration for buckets. |
| `ip_filter` | `map(object)` | `{}` | IP filter configuration per bucket. |
| `set_admin_roles` | `bool` | `false` | Grant `roles/storage.objectAdmin` to `admins` and `bucket_admins`. |
| `admins` | `list(string)` | `[]` | IAM members granted object admin on all buckets. |
| `bucket_admins` | `map(string)` | `{}` | Per-bucket object admins (comma-delimited IAM members). |
| `set_creator_roles` | `bool` | `false` | Grant `roles/storage.objectCreator` to `creators` and `bucket_creators`. |
| `creators` | `list(string)` | `[]` | IAM members granted object creator on all buckets. |
| `bucket_creators` | `map(string)` | `{}` | Per-bucket object creators (comma-delimited IAM members). |
| `set_viewer_roles` | `bool` | `false` | Grant `roles/storage.objectViewer` to `viewers` and `bucket_viewers`. |
| `viewers` | `list(string)` | `[]` | IAM members granted object viewer on all buckets. |
| `bucket_viewers` | `map(string)` | `{}` | Per-bucket object viewers (comma-delimited IAM members). |
| `set_storage_admin_roles` | `bool` | `false` | Grant `roles/storage.admin` to `storage_admins` and `bucket_storage_admins`. |
| `storage_admins` | `list(string)` | `[]` | IAM members granted storage admin on all buckets. |
| `bucket_storage_admins` | `map(string)` | `{}` | Per-bucket storage admins (comma-delimited IAM members). |
| `set_hmac_key_admin_roles` | `bool` | `false` | Grant `roles/storage.hmacKeyAdmin` to HMAC key admins. |
| `hmac_key_admins` | `list(string)` | `[]` | IAM members granted HMAC key admin on all buckets. |
| `bucket_hmac_key_admins` | `map(string)` | `{}` | Per-bucket HMAC key admins (comma-delimited IAM members). |
| `set_hmac_access` | `bool` | `false` | Set S3-compatible access to GCS. |
| `hmac_service_accounts` | `map(string)` | `{}` | HMAC service accounts to grant access to GCS. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/12.3.0?tab=inputs) for full details.

## Examples

### Terragrunt state bucket

```hcl
dependency "iam_project" {
  config_path = "../../project"
}

inputs = {
  project_id = dependency.iam_project.outputs.project_id
  names      = ["terragrunt-state"]
  prefix     = "academeez-k8s-flux"
  location   = "EU"
  versioning = {
    terragrunt-state = true
  }
  public_access_prevention = "enforced"
}
```

### Bucket with IAM admins

```hcl
dependency "project" {
  config_path = "../../project"
}

dependency "operators_group" {
  config_path = "../../../groups/terragrunt"
}

inputs = {
  project_id      = dependency.project.outputs.project_id
  names           = ["artifacts"]
  prefix          = "my-org"
  location        = "europe-west1"
  set_admin_roles = true
  admins = [
    "group:${dependency.operators_group.outputs.id}"
  ]
}
```

### Multiple buckets with per-bucket settings

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id = dependency.project.outputs.project_id
  names      = ["logs", "backups"]
  prefix     = "platform-dev"
  location   = "EU"
  versioning = {
    backups = true
  }
  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age = 90
      }
    }
  ]
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `names` | Map of bucket name suffix to full bucket name. |
| `names_list` | List of full bucket names. |
| `urls` | Map of bucket name suffix to bucket URL. |
| `urls_list` | List of bucket URLs. |
| `bucket` | Bucket resource (for single-bucket use). |
| `name` | Full bucket name (for single-bucket use). |
| `url` | Bucket URL (for single-bucket use). |
| `buckets` | Bucket resources as a list. |
| `buckets_map` | Bucket resources keyed by name suffix. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/12.3.0?tab=outputs) for the full list.
