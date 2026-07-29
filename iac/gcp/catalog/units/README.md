# Catalog units

Reusable Terragrunt units consumed via `include`, `terragrunt catalog` scaffolding, or stack `unit` blocks.

## `values.*` and partial configuration

Units wire Terraform module inputs from `terragrunt.values.hcl` / stack `values` using `values.*`. Terragrunt catalog discovers those references for scaffolding prompts and generated `terragrunt.values.hcl` files.

Stacks and `autoinclude` blocks often supply only a subset of inputs (for example `parent` and `names` from a `dependency`). Required keys must not be read unconditionally from `values` or parsing fails when they are omitted.

Each unit therefore builds `inputs` with:

1. **Optional inputs** — a map of `try(values.<key>, <default>)` entries (catalog still sees each `values.<key>` reference).
2. **Required inputs** — merged only when the value is present, e.g. `try(values.parent, "") != "" ? { parent = values.parent } : {}`.

Optional keys do not need to appear in stack `values` or in a minimal `terragrunt.values.hcl`.

When a stack `autoinclude` block defines `inputs`, it replaces the unit `inputs` block (shallow merge). Use `inputs = merge({ ...optional defaults... }, { ...wiring... })` in `autoinclude`, or omit keys and rely on the Terraform module defaults.
