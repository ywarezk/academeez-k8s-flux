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

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `name` | yes | — | The name for the project. |
| `billing_account` | yes | — | The ID of the billing account to associate this project with. |

All other `values.*` fields in this unit are optional and use the module defaults documented below.

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
| `name` | `string` | The name for the project. |
| `billing_account` | `string` | The ID of the billing account to associate this project with. |

You must also set **either** `folder_id` (project under a folder) **or** `org_id` (project under an organization) for a valid project layout. In practice, most live configs pass both when the folder lives under an org.

## Commonly set in live

| Input | Notes |
|-------|--------|
| `folder_id` | Folder ID from a folder unit dependency. |
| `org_id` | Often from live `root.hcl` locals. |
| `billing_account` | Often from live `root.hcl` locals. |
| `random_project_id` | `true` for globally unique project IDs. |
| `budget_amount` | Set when you want billing budget alerts. |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `random_project_id` | `bool` | `false` | Adds a suffix of 4 random characters to the `project_id`. |
| `random_project_id_length` | `number` | `null` | Length of random suffix when using `random_string` (recommended for CI). |
| `universe_prefix` | `string` | `""` | Universe short name prefix for the project ID (lowercase alphanumeric). |
| `org_id` | `string` | `null` | The organization ID. |
| `domain` | `string` | `""` | The domain name (optional). |
| `project_id` | `string` | `""` | The ID to give the project; if not provided, `name` is used. |
| `svpc_host_project_id` | `string` | `""` | Host project ID for shared VPC. |
| `enable_shared_vpc_host_project` | `bool` | `false` | Whether this project is a shared VPC host (do not set `svpc_host_project_id` when true). |
| `folder_id` | `string` | `""` | The ID of a folder to host this project. |
| `group_name` | `string` | `""` | Group to control the project via `group_role`. |
| `principal_set` | `string` | `""` | Principal set URI (`principalSet://...`); used instead of `group_name` when set. |
| `group_role` | `string` | `"roles/editor"` | Role for the controlling group. |
| `create_project_sa` | `bool` | `true` | Whether to create the default project service account. |
| `project_sa_name` | `string` | `"project-service-account"` | Default service account name. |
| `project_sa_description` | `string` | `null` | Description for the default project service account. |
| `sa_role` | `string` | `""` | Role for the default service account. |
| `activate_apis` | `list(string)` | `["compute.googleapis.com"]` | APIs to enable on the project. |
| `activate_api_identities` | `list(object)` | `[]` | Service identities to force-create (`api`, `roles`). |
| `usage_bucket_name` | `string` | `""` | GCS bucket for GCE usage reports. |
| `usage_bucket_prefix` | `string` | `""` | Prefix in the usage reports bucket. |
| `shared_vpc_subnets` | `list(string)` | `[]` | Fully qualified shared VPC subnet IDs. |
| `labels` | `map(string)` | `{}` | Labels for the project. |
| `bucket_project` | `string` | `""` | Project in which to create optional state bucket. |
| `bucket_name` | `string` | `""` | Optional GCS bucket name (e.g. for Terraform state). |
| `bucket_location` | `string` | `"US"` | Location for the optional GCS bucket. |
| `bucket_versioning` | `bool` | `false` | Versioning on the optional GCS bucket. |
| `bucket_labels` | `map(string)` | `{}` | Labels for the optional GCS bucket. |
| `bucket_force_destroy` | `bool` | `false` | Force-delete bucket objects on destroy. |
| `bucket_ula` | `bool` | `true` | Uniform bucket-level access on the optional bucket. |
| `bucket_pap` | `string` | `"inherited"` | Public access prevention (`enforced` or `inherited`). |
| `auto_create_network` | `bool` | `false` | Create the default network. |
| `lien` | `bool` | `false` | Lien to prevent accidental project deletion. |
| `disable_services_on_destroy` | `bool` | `true` | Disable project services when resources are destroyed. |
| `default_service_account` | `string` | `"disable"` | Default SA handling: `delete`, `deprivilege`, `disable`, or `keep`. |
| `disable_dependent_services` | `bool` | `true` | Disable dependent services when a service is destroyed. |
| `budget_amount` | `number` | `null` | Budget alert amount; omit to skip budget creation. |
| `budget_display_name` | `string` | `null` | Display name for the budget. |
| `budget_alert_pubsub_topic` | `string` | `null` | Pub/Sub topic for budget messages. |
| `budget_monitoring_notification_channels` | `list(string)` | `[]` | Monitoring notification channel resource names. |
| `budget_alert_spent_percents` | `list(number)` | `[0.5, 0.7, 1.0]` | Spend thresholds for budget alerts. |
| `budget_alert_spend_basis` | `string` | `"CURRENT_SPEND"` | Basis for budget threshold alerts. |
| `budget_labels` | `map(string)` | `{}` | Budget filter label (0 or 1 key). |
| `budget_calendar_period` | `string` | `null` | `MONTH`, `QUARTER`, `YEAR`, or `CUSTOM`. |
| `budget_custom_period_start_date` | `string` | `null` | Start date (`DD-MM-YYYY`) when period is `CUSTOM`. |
| `budget_custom_period_end_date` | `string` | `null` | End date (`DD-MM-YYYY`) when period is `CUSTOM`. |
| `vpc_service_control_attach_enabled` | `bool` | `false` | Attach project to VPC-SC perimeter (enforced). |
| `vpc_service_control_attach_dry_run` | `bool` | `false` | Attach project to VPC-SC perimeter (dry run). |
| `vpc_service_control_perimeter_name` | `string` | `null` | VPC Service Controls perimeter name. |
| `vpc_service_control_sleep_duration` | `string` | `"5s"` | Wait before shared VPC attach after VPC-SC attach. |
| `grant_services_security_admin_role` | `bool` | `false` | Grant GKE service agent Security Admin on host project. |
| `grant_network_role` | `bool` | `true` | Grant `networkUser` on host project/subnets. |
| `consumer_quotas` | `list(object)` | `[]` | Quota overrides (`service`, `metric`, `dimensions`, `limit`, `value`). |
| `default_network_tier` | `string` | `""` | Default network service tier for the project. |
| `essential_contacts` | `map(list(string))` | `{}` | Essential contacts by notification category. |
| `language_tag` | `string` | `"en-US"` | Language for essential contact notifications. |
| `tag_binding_values` | `list(string)` | `[]` | Tag values to bind the project to. |
| `cloud_armor_tier` | `string` | `null` | Managed protection tier (`CA_STANDARD`, `CA_ENTERPRISE_PAYGO`). |
| `deletion_policy` | `string` | `"PREVENT"` | Project deletion policy: `DELETE` or `PREVENT`. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/18.3.0?tab=inputs) for the full list.

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

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/18.3.0?tab=outputs) for the full list.
