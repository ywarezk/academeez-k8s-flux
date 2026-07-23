

include "root" {
  path = find_in_parent_folders("root.hcl")
}


dependency "terragrunt_group" {
  config_path = "../../../groups/terragrunt"
}


include "bucket_permissions" {
  path = "${get_repo_root()}/iac/gcp/catalog/units/iam/storage-bucket/terragrunt.hcl"
}

inputs = {
  storage_buckets = ["academeez-k8s-flux-terragrunt-state"]
  mode            = "additive"
  bindings = {
    "roles/storage.admin" = [
      "group:${dependency.terragrunt_group.outputs.id}",
    ]
  }
}