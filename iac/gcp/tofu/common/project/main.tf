# 
# Create the gcp project
#
# Created May 4th, 2024
# @author ywarezk
# @license MIT
# 

variable "project" {
  type        = string
  description = "The project id of the course project"
}

variable "org_id" {
  type        = string
  description = "The organization id"
}

variable "billing_account" {
  type        = string
  description = "The billing account id"
}

variable "folder_id" {
  type        = string
  description = "The folder id of academeez"
}

module "project" {
  source              = "terraform-google-modules/project-factory/google"
  version             = "~> 15.0"
  name                = var.project
  org_id              = var.org_id
  billing_account     = var.billing_account
  random_project_id   = false
  auto_create_network = false
  create_project_sa   = false
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "gkehub.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
  folder_id     = var.folder_id
  budget_amount = 30
}

# output the entire module.project
output "project" {
  value = module.project
}
