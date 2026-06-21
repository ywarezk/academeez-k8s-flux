/**
 * Environment stack — provisions a GCP folder and project for one environment.
 *
 * Expected values (passed by the calling stack):
 *   name - Environment name used for the folder and project (e.g. "non-prod-temp", "prod").
 *
 * Generated units:
 *   folder  - GCP folder under the organization.
 *   project - GCP project under the folder (depends on folder outputs via autoinclude).
 *
 * Created June 17th, 2026
 * @author ywarezk
 */

locals {
  units_path      = "${get_repo_root()}/iac/catalog/units"
  catalog_version = "v0.0.1"
  catalog_units   = "git::https://github.com/ywarezk/academeez-k8s-flux.git//iac/catalog/units"
}

unit "folder" {
  source = "${local.catalog_units}/folder?ref=${local.catalog_version}"
  path   = "folder"

  values = {
    names = [values.name]
  }
}

unit "project" {
  source = "${local.units_path}/project"
  path   = "project"

  autoinclude {
    dependency "folder" {
      config_path = unit.folder.path

      mock_outputs_allowed_terraform_commands = ["plan", "validate"]
      mock_outputs = {
        id = "folders/000000000000"
      }
    }

    inputs = {
      name      = values.name
      folder_id = dependency.folder.outputs.id
    }
  }
}