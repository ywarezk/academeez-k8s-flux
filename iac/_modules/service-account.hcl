/**
 * terragrunt function to create a service account
 *
 * Created April 18th, 2025
 * @author: ywarezk 
 */

terraform {
  source = "tfr:///terraform-google-modules/service-accounts/google?version=4.5.3"
}

inputs = {
  prefix = "az-k8s"
}