# Configuration

Org- and account-specific Terragrunt settings for this live environment. `root.hcl` loads these files at runtime.

| Committed (shared) | Local only (gitignored) |
|--------------------|-------------------------|
| `billing.example.hcl` | `billing.hcl` |
| `common.example.hcl` | `common.hcl` |
| `region.example.hcl` | `region.hcl` |

The `*.example.hcl` files document the expected shape. Your real values live in the matching `*.hcl` files, which are not committed.

## Generate your local config

### New live environment

If you do not have a `root.hcl` yet, scaffold the **root** template instead — it depends on this config template and creates both `root.hcl` and `config/` in one step (see [`templates/root`](https://github.com/Nerdeez/terragrunt-catalog/tree/main/iac/gcp/catalog/templates/root) when available).

### This folder only

If `root.hcl` already exists (or you only need to regenerate local config), generate config from the **live** directory (the parent of this `config/` folder).

#### Catalog TUI

```bash
cd ..   # live directory (parent of config/)

terragrunt catalog github.com/Nerdeez/terragrunt-catalog
```

Select **Live config template**, press `s`, and scaffold into the live directory.

#### Scaffold directly

From the catalog git repository:

```bash
cd ..   # live directory

terragrunt scaffold \
  'git::https://github.com/Nerdeez/terragrunt-catalog.git//iac/gcp/catalog/templates/config?ref=<version>' \
  --output-folder .
```

Pin `ref` to a catalog release tag. Quote the URL in zsh — `?` is a glob character.

#### From a local checkout of the catalog

```bash
cd ..   # live directory

terragrunt scaffold ../catalog/templates/config --output-folder .
```

## Find your GCP values

Run these before scaffolding (the same hints appear in the interactive prompts):

```bash
# Organization ID and Workspace customer ID
gcloud organizations list \
  --format='table(displayName,name,directoryCustomerId)'

# Projects
gcloud projects list \
  --format='table(projectId,name)'

# Billing accounts
gcloud billing accounts list \
  --format='table(name,displayName,open)'

# Regions
gcloud compute regions list \
  --format='table(name,status)'
```

| Prompt variable | Written to | Notes |
|-----------------|------------|-------|
| `OrgId` | `common.hcl` → `org_id` | Numeric ID from `organizations/123456789` |
| `CommonProject` | `common.hcl` → `common_project` | Shared project (remote state, APIs) |
| `CustomerId` | `common.hcl` → `customer_id` | `directoryCustomerId` (for example `C01234567`) |
| `BillingAccount` | `billing.hcl` → `billing_account` | ID after `billingAccounts/` |
| `BillingProject` | `billing.hcl` → `billing_project` | Usually same as `common_project` |
| `Region` | `region.hcl` → `region` | Default: `us-central1` |

## Manual alternative

If you prefer not to scaffold, copy the example files and edit them by hand:

```bash
cp billing.example.hcl billing.hcl
cp common.example.hcl common.hcl
cp region.example.hcl region.hcl
```

## How `root.hcl` uses these files

```hcl
region_config  = read_terragrunt_config(find_in_parent_folders("config/region.hcl")).locals
billing_config = read_terragrunt_config(find_in_parent_folders("config/billing.hcl")).locals
common_config  = read_terragrunt_config(find_in_parent_folders("config/common.hcl")).locals
```

Full template documentation: [catalog templates/config README](https://github.com/Nerdeez/terragrunt-catalog/blob/main/iac/gcp/catalog/templates/config/README.md).
