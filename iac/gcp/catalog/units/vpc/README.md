<!-- Frontmatter
name: GCP VPC Network
description: Create a Google Cloud VPC network with subnets, routes, and firewall rules.
tags:
  - unit
  - gcp
  - google
  - vpc
  - network
-->

# GCP VPC Network

Creates a custom-mode VPC network with subnets, optional routes, firewall rules, and Private Service Access (PSA) peering for managed services such as Cloud SQL.

This is a **Unit** component. It wraps the [terraform-google-modules/network/google](https://registry.terraform.io/modules/terraform-google-modules/network/google) module (v18.1.2).

> **Note:** For private-IP Cloud SQL, enable `private_service_access_config` in this unit, then pass `network_self_link` to [`db/postgresql`](../db/postgresql/) via `ip_configuration.private_network`.

## Scaffolding

From the catalog TUI, select this unit and press `s` to scaffold it into your working directory. Terragrunt copies the unit files in place and prompts for each `values.*` reference (press `x` on optional fields to keep the `try()` default). It writes a `terragrunt.values.hcl` with the answers you provide.

| Value | Required | Default | Description |
|-------|----------|---------|-------------|
| `project_id` | yes | — | Project ID where the VPC will be created. |
| `network_name` | yes | — | VPC network name. |
| `subnets` | yes | — | List of subnet definitions (`subnet_name`, `subnet_ip`, `subnet_region`, …). |
| `routing_mode` | no | `"GLOBAL"` | Network routing mode (`GLOBAL` or `REGIONAL`). |
| `shared_vpc_host` | no | `false` | Make this project a Shared VPC host. |
| `subnets_region` | no | `null` | Region for all subnets when not set per subnet. |
| `secondary_ranges` | no | `{}` | Secondary IP ranges keyed by subnet name (e.g. for GKE pods). |
| `routes` | no | `[]` | Custom routes in the VPC. |
| `ingress_rules` | no | `[]` | Ingress firewall rules. |
| `egress_rules` | no | `[]` | Egress firewall rules. |
| `mtu` | no | `0` | Network MTU (`0` = provider default 1460). |
| `private_service_access_config` | no | PSA disabled (module default) | Enable VPC peering for managed services (Cloud SQL private IP, etc.). Press `x` when scaffolding to omit; add the full object in `terragrunt.values.hcl` when enabling PSA. |

Set `project_id`, `network_name`, and `subnets` together when scaffolding a real VPC.

After scaffolding, wire the unit into your live repository and supply project-specific configuration there.

In a stack `unit` block you only need to set the values you care about; optional keys use the `try()` defaults in the catalog unit. Required keys such as `project_id`, `network_name`, and `subnets` can be omitted from `values` when you supply them via an `autoinclude` `inputs` block instead (see [catalog units README](../README.md)).

## Consumption

Include this unit from your live repository and supply module inputs in your `terragrunt.hcl`:

```hcl
include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "vpc" {
  path = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/gcp/catalog/units/vpc?ref=<version>"
}

dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  network_name = "platform-vpc"
  subnets = [
    {
      subnet_name   = "app"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    }
  ]
}
```

Project-specific values (`project_id`, `network_name`, CIDR ranges, regions) belong in the **live** repository, not in the catalog.

## Required inputs

| Input | Type | Description |
|-------|------|-------------|
| `project_id` | `string` | Project ID where the VPC will be created. |
| `network_name` | `string` | VPC network name. |
| `subnets` | `list(object)` | Subnets to create (at least one for a usable custom-mode VPC). |

## Commonly set in live

| Input | Notes |
|-------|--------|
| `subnets` | Define CIDR blocks and regions for workloads (GKE, Cloud Run, VMs). |
| `secondary_ranges` | Pod and service ranges for GKE clusters. |
| `ingress_rules` / `egress_rules` | Restrict traffic to/from subnets. |
| `shared_vpc_host` | Set `true` on the host project for Shared VPC. |
| `private_service_access_config` | Enable before creating private-IP Cloud SQL in this VPC. |
| `routes` | Custom egress or internal routing (e.g. via Cloud NAT or proxy). |

## Optional inputs

| Input | Type | Default | Description |
|-------|------|---------|-------------|
| `routing_mode` | `string` | `"GLOBAL"` | `GLOBAL` or `REGIONAL` routing. |
| `shared_vpc_host` | `bool` | `false` | Shared VPC host project. |
| `subnets_region` | `string` | `null` | Default region for all subnets. |
| `secondary_ranges` | `map(list(object))` | `{}` | Secondary ranges per subnet name. |
| `routes` | `list(object)` | `[]` | VPC routes. |
| `firewall_rules` | `list(object)` | `[]` | Deprecated; use `ingress_rules` / `egress_rules`. |
| `delete_default_internet_gateway_routes` | `bool` | `false` | Remove default internet gateway routes. |
| `description` | `string` | `""` | VPC description. |
| `auto_create_subnetworks` | `bool` | `false` | Auto subnet mode (not recommended for production). |
| `mtu` | `number` | `0` | Network MTU (1300–8896; `0` = 1460). |
| `ingress_rules` | `list(object)` | `[]` | Ingress firewall rules. |
| `egress_rules` | `list(object)` | `[]` | Egress firewall rules. |
| `enable_ipv6_ula` | `bool` | `false` | Enable IPv6 ULA (permanent). |
| `internal_ipv6_range` | `string` | `null` | `/48` ULA range from `fd20::/20`. |
| `network_firewall_policy_enforcement_order` | `string` | `null` | Firewall policy evaluation order. |
| `network_profile` | `string` | `null` | Network profile URL. |
| `bgp_always_compare_med` | `bool` | `false` | Cloud Router MED comparison. |
| `bgp_best_path_selection_mode` | `string` | `"LEGACY"` | `STANDARD` or `LEGACY`. |
| `bgp_inter_region_cost` | `string` | `null` | `DEFAULT` or `ADD_COST_TO_MED`. |
| `private_service_access_config` | `object` | PSA disabled | PSA peering for managed services. |

### `private_service_access_config`

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enable_private_services_connection` | `bool` | `false` | Create PSA peering to `servicenetworking.googleapis.com`. |
| `address_name` | `string` | `"private-ip-address"` | Name of the reserved internal range. |
| `prefix_length` | `number` | `16` | Size of the reserved range (e.g. `/16`). |

See the [module inputs](https://registry.terraform.io/modules/terraform-google-modules/network/google/18.1.2?tab=inputs) for full details.

## Examples

### Basic VPC with two subnets

Based on the [simple_project](https://github.com/terraform-google-modules/terraform-google-network/tree/v18.1.2/examples/simple_project) example:

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  network_name = "platform-vpc"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "app"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    },
    {
      subnet_name           = "data"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "europe-west1"
      subnet_private_access = true
      subnet_flow_logs      = true
    }
  ]
}
```

### VPC with Private Service Access (for private Cloud SQL)

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  network_name = "platform-vpc"

  subnets = [
    {
      subnet_name   = "app"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    }
  ]

  private_service_access_config = {
    enable_private_services_connection = true
    address_name                       = "private-ip-address"
    prefix_length                      = 16
  }
}
```

Then wire Cloud SQL to this VPC:

```hcl
dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  # ... postgresql inputs ...
  ip_configuration = {
    ipv4_enabled    = false
    private_network = dependency.vpc.outputs.network_self_link
  }
}
```

### GKE-ready VPC with secondary ranges

```hcl
dependency "project" {
  config_path = "../../project"
}

inputs = {
  project_id   = dependency.project.outputs.project_id
  network_name = "gke-vpc"

  subnets = [
    {
      subnet_name   = "gke-nodes"
      subnet_ip     = "10.0.0.0/20"
      subnet_region = "europe-west1"
    }
  ]

  secondary_ranges = {
    gke-nodes = [
      {
        range_name    = "gke-pods"
        ip_cidr_range = "10.4.0.0/14"
      },
      {
        range_name    = "gke-services"
        ip_cidr_range = "10.8.0.0/20"
      }
    ]
  }
}
```

## Outputs

Common outputs from this module:

| Output | Description |
|--------|-------------|
| `network_name` | VPC name. |
| `network_id` | VPC resource ID. |
| `network_self_link` | VPC self link (use for `private_network` on Cloud SQL). |
| `subnets` | Map of created subnets keyed by `region/name`. |
| `subnets_names` | List of subnet names. |
| `subnets_self_links` | List of subnet self links. |
| `subnets_ips` | List of subnet CIDR blocks. |
| `route_names` | Custom route names. |

See the [module outputs](https://registry.terraform.io/modules/terraform-google-modules/network/google/18.1.2?tab=outputs) for the full list.
