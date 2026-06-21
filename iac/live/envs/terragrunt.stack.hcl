/**
 * Live environments — each stack block provisions one environment via the catalog env stack.
 *
 * Add an environment by adding a new stack block below.
 *
 * Created June 17th, 2026
 * This code is part of the infrastructure course given free at academeez: https://www.academeez.com/courses/terraform
 */

locals {
  env_stack = "${get_repo_root()}/iac/catalog/stacks/env"
}

stack "non-prod-temp" {
  source = local.env_stack
  path   = "non-prod-temp"

  values = {
    name = "non-prod-temp"
  }
}
