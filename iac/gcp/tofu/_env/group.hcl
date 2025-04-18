/**
 * terragrunt function to create a group
 *
 * Created April 18th, 2025
 * @author: ywarezk 
 */

locals {
  customer_id = yamldecode(file(find_in_parent_folders("common_vars.yaml"))).customer_id
}

terraform {
  source = "tfr:///terraform-google-modules/group/google?version=0.7.0"
}

inputs = {
  customer_id = local.customer_id
  owners      = ["az-k8s-iam@academeez-k8s-flux-iam-c55b.iam.gserviceaccount.com"]
}