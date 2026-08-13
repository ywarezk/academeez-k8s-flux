<!-- Frontmatter
name: GCP Cloud SQL PostgreSQL
description: Create a Google Cloud SQL PostgreSQL instance.
tags:
  - unit
  - gcp
  - google
  - database
  - postgresql
  - cloud-sql
-->

# GCP Cloud SQL PostgreSQL

Creates a Google Cloud SQL PostgreSQL instance (with optional read replicas, databases, and users).

This is a **Unit** component. It wraps the [terraform-google-modules/sql-db/google//modules/postgresql](https://registry.terraform.io/modules/terraform-google-modules/sql-db/google/28.2.0/submodules/postgresql) module (v28.2.0).

> **Note:** For private IP access, create a VPC first with [`vpc`](../vpc/) and enable `private_service_access_config`, then set `ip_configuration.private_network` to the VPC `network_self_link` output in this unit.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `project_id` | yes | — | Project ID where the Cloud SQL instance will be created. |
| `name` | yes | — | Cloud SQL instance name. |
| `database_version` | yes | — | PostgreSQL version (e.g. `POSTGRES_14`, `POSTGRES_15`, `POSTGRES_16`, `POSTGRES_17`). |
| `region` | no | `"us-central1"` | Region for the Cloud SQL instance. |
| `tier` | no | `"db-f1-micro"` | Machine tier (e.g. `db-f1-micro`, `db-custom-1-3840`, `db-perf-optimized-N-2`). |
| `edition` | no | `null` | Instance edition (`ENTERPRISE` or `ENTERPRISE_PLUS`). |
| `availability_type` | no | `"ZONAL"` | `ZONAL` or `REGIONAL` (HA). |
| `zone` | no | `null` | Primary zone (e.g. `europe-west1-b`). |
| `random_instance_name` | no | `false` | Append a random suffix to the instance name. |
| `deletion_protection` | no | `true` | Block Terraform from deleting the instance. |
| `enable_default_db` | no | `true` | Create the default database. |
| `db_name` | no | `"default"` | Name of the default database. |
| `enable_default_user` | no | `true` | Create the default user. |
| `user_name` | no | `"default"` | Default database user name. |
| `user_password` | no | `""` | Default user password (auto-generated when empty). |
| `ip_configuration` | no | `{}` | Public/private IP, SSL, authorized networks, PSC settings. |
| `backup_configuration` | no | `{}` | Automated backup settings. |
| `read_replicas` | no | `[]` | Read replica definitions. |
| `user_labels` | no | `{}` | Labels on the instance. |

Set `project_id`, `name`, and `database_version` together when scaffolding a real instance.

After scaffolding, wire the unit into your live repository and supply project-specific configuration there.

In a stack `unit` block you only need to set the values you care about; optional keys use the `try()` defaults in the catalog unit. Required keys such as `project_id`, `name`, and `database_version` can be omitted from `values` when you supply them via an `autoinclude` `inputs` block instead (see [catalog units README](../../README.md)).

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "postgresql" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/db/postgresql?ref=<version>"
}

dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id       = dependency.project.outputs.project_id
  name             = "app-db"
  database_version = "POSTGRES_15"
  region           = "europe-west1"
  tier             = "db-f1-micro"
  deletion_protection = false
}
```

Project-specific values (`project_id`, `name`, `region`, networking) belong in the **live** repository, not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `project_id` | `string` | Project ID where the Cloud SQL instance will be created. |
| `name` | `string` | Cloud SQL instance name. |
| `database_version` | `string` | PostgreSQL version (e.g. `POSTGRES_14`, `POSTGRES_15`). |

## Commonly set in live

| Input | Notes |
|-------|--------|
| `region` / `zone` | Match your workload region and zone. |
| `tier` / `edition` | Size and edition; use `ENTERPRISE_PLUS` with `db-perf-optimized-*` tiers when needed. |
| `availability_type` | Set to `REGIONAL` for high availability. |
| `ip_configuration` | Public IP with `authorized_networks`, or private IP via `private_network`. |
| `backup_configuration` | Enable backups and point-in-time recovery for production. |
| `deletion_protection` | Keep `true` in production; set `false` for ephemeral environments. |
| `read_replicas` | Add read replicas for scaling reads. |
| `user_password` | Prefer Secret Manager or a generated password over plain text in git. |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `region` | `string` | `"us-central1"` | Region of the Cloud SQL resources. |
| `edition` | `string` | `null` | `ENTERPRISE` or `ENTERPRISE_PLUS`. |
| `maintenance_version` | `string` | `null` | Software maintenance version (updates trigger restart). |
| `availability_type` | `string` | `"ZONAL"` | `ZONAL` or `REGIONAL`. |
| `enable_default_db` | `bool` | `true` | Create the default database. |
| `db_name` | `string` | `"default"` | Default database name. |
| `enable_default_user` | `bool` | `true` | Create the default user. |
| `user_name` | `string` | `"default"` | Default user name. |
| `user_password` | `string` | `""` | Default user password (random when empty). |
| `root_password` | `string` | `null` | Initial root password during creation. |
| `deletion_protection` | `bool` | `true` | Block Terraform deletion. |
| `database_flags` | `list(object)` | `[]` | PostgreSQL database flags. |
| `database_deletion_policy` | `string` | `null` | Deletion policy for databases (`ABANDON`). |
| `user_deletion_policy` | `string` | `null` | Deletion policy for users (`ABANDON`). |
| `data_cache_enabled` | `bool` | `false` | Enable data cache (`ENTERPRISE_PLUS` only). |
| `additional_users` | `list(object)` | `[]` | Extra users to create. |
| `additional_databases` | `list(object)` | `[]` | Extra databases to create. |
| `master_instance_name` | `string` | `null` | Master instance name for failover replica. |
| `failover_dr_replica_name` | `string` | `null` | DR replica identifier for cross-region failover. |
| `instance_type` | `string` | `"CLOUD_SQL_INSTANCE"` | Instance type (`READ_REPLICA_INSTANCE` when replicating). |
| `random_instance_name` | `bool` | `false` | Random suffix on instance name. |
| `tier` | `string` | `"db-f1-micro"` | Machine tier. |
| `zone` | `string` | `null` | Primary zone. |
| `secondary_zone` | `string` | `null` | Preferred zone for replica. |
| `follow_gae_application` | `string` | `null` | GAE app whose zone to remain in. |
| `activation_policy` | `string` | `"ALWAYS"` | `ALWAYS`, `NEVER`, or `ON_DEMAND`. |
| `deletion_protection_enabled` | `bool` | `false` | Protection from accidental deletion across all surfaces. |
| `read_replica_deletion_protection_enabled` | `bool` | `false` | Replica deletion protection across all surfaces. |
| `disk_autoresize` | `bool` | `true` | Auto-increase disk size. |
| `disk_autoresize_limit` | `number` | `0` | Max auto-resize disk size (GB). |
| `disk_size` | `number` | `10` | Disk size in GB. |
| `disk_type` | `string` | `"PD_SSD"` | Disk type. |
| `pricing_plan` | `string` | `"PER_USE"` | Pricing plan. |
| `maintenance_window_day` | `number` | `1` | Maintenance day (1–7). |
| `maintenance_window_hour` | `number` | `23` | Maintenance hour (0–23). |
| `maintenance_window_update_track` | `string` | `"canary"` | `canary` or `stable`. |
| `user_labels` | `map(string)` | `{}` | Instance labels. |
| `deny_maintenance_period` | `list(object)` | `[]` | Deny maintenance window. |
| `backup_configuration` | `object` | `{}` | Backup settings. |
| `final_backup_config` | `object` | `null` | Final backup on delete settings. |
| `insights_config` | `object` | `null` | Query insights settings. |
| `password_validation_policy_config` | `object` | `null` | Password policy settings. |
| `ip_configuration` | `object` | `{}` | IP, SSL, authorized networks, PSC. |
| `read_replicas` | `list(object)` | `[]` | Read replica configurations. |
| `read_replica_name_suffix` | `string` | `""` | Suffix for read replica names. |
| `db_charset` | `string` | `""` | Default database charset. |
| `db_collation` | `string` | `""` | Default database collation. |
| `iam_users` | `list(object)` | `[]` | IAM database users. |
| `create_timeout` | `string` | `"30m"` | Create operation timeout. |
| `update_timeout` | `string` | `"30m"` | Update operation timeout. |
| `delete_timeout` | `string` | `"30m"` | Delete operation timeout. |
| `encryption_key_name` | `string` | `null` | CMEK encryption key. |
| `module_depends_on` | `list(any)` | `[]` | Explicit module dependencies. |
| `read_replica_deletion_protection` | `bool` | `false` | Block Terraform replica deletion. |
| `enable_random_password_special` | `bool` | `false` | Special chars in generated passwords. |
| `connector_enforcement` | `bool` | `false` | Require Cloud SQL Auth Proxy / connector. |
| `enable_google_ml_integration` | `bool` | `false` | Enable ML integration. |
| `enable_dataplex_integration` | `bool` | `false` | Enable Dataplex integration. |
| `database_integration_roles` | `list(string)` | `[]` | Roles for GCP service integration. |
| `use_autokey` | `bool` | `false` | Use Cloud KMS autokeys for CMEK. |
| `create_kms_key_handle` | `bool` | `true` | Create KMS key handle when using autokey. |
| `kms_key_handle_name` | `string` | `null` | KMS key handle name override. |
| `retain_backups_on_delete` | `bool` | `false` | Retain backups after instance deletion. |
| `connection_pool_config` | `object` | `null` | Managed connection pool settings. |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/sql-db/google/28.2.0/submodules/postgresql?tab=inputs) for full details.

## Examples

### Public PostgreSQL instance

Based on the [postgresql-public](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/main/examples/postgresql-public) example:

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id         = dependency.project.outputs.project_id
  name               = "app-db"
  random_instance_name = true
  database_version   = "POSTGRES_14"
  region             = "europe-west1"
  zone               = "europe-west1-b"
  tier               = "db-f1-micro"
  deletion_protection = false

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    ssl_mode            = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    authorized_networks = []
  }
}
```

### Regional HA with backups and read replica

Based on the [postgresql-ha](https://github.com/terraform-google-modules/terraform-google-sql-db/tree/main/examples/postgresql-ha) example:

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id       = dependency.project.outputs.project_id
  name             = "app-db-ha"
  database_version = "POSTGRES_15"
  region           = "europe-west1"
  tier             = "db-custom-1-3840"
  zone             = "europe-west1-b"
  availability_type = "REGIONAL"
  deletion_protection = false

  backup_configuration = {
    enabled           = true
    start_time        = "03:00"
    retained_backups  = 7
    retention_unit    = "COUNT"
  }

  ip_configuration = {
    ipv4_enabled = true
    ssl_mode     = "ENCRYPTED_ONLY"
  }

  read_replica_name_suffix = "-replica"
  read_replicas = [
    {
      name              = "0"
      zone              = "europe-west1-c"
      availability_type = "REGIONAL"
      tier              = "db-custom-1-3840"
      disk_type         = "PD_SSD"
      user_labels       = { role = "read-replica" }
      ip_configuration = {
        ipv4_enabled = true
        ssl_mode     = "ENCRYPTED_ONLY"
      }
    }
  ]
}
```

### Private IP (requires VPC with PSA)

Enable `private_service_access_config` on the [`vpc`](../vpc/) unit first, then:

```hcl
dependency "project" {
  config_path = "../../project"
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

inputs = {
  project_id       = dependency.project.outputs.project_id
  name             = "app-db-private"
  database_version = "POSTGRES_15"
  region           = "europe-west1"

  ip_configuration = {
    ipv4_enabled    = false
    private_network = dependency.vpc.outputs.network_self_link
  }
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `instance_name` | Master instance name. |
| `instance_connection_name` | Connection name for Cloud SQL Auth Proxy / connectors. |
| `public_ip_address` | Public IPv4 address (when enabled). |
| `private_ip_address` | Private IPv4 address (when enabled). |
| `generated_user_password` | Auto-generated default user password (sensitive). |
| `read_replica_instance_names` | Read replica instance names. |
| `env_vars` | Common connection environment variables. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/sql-db/google/28.2.0/submodules/postgresql?tab=outputs) for the full list.
