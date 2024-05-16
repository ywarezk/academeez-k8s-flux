

variable "org_id" {
	description = "The GCP organization ID"
	type        = string	
}

variable "billing_account" {
	description = "The GCP billing account ID"
	type        = string	
}

variable "project_name" {
  description = "The GCP project name"
  type        = string	
}

variable "region" {
	description = "The GCP region"
	type        = string	
}

variable "github_org" { 
	description = "The GitHub organization name"
	type        = string	
}

variable "github_repository" {
	description = "The GitHub repository name"
	type        = string	
}

variable "github_token" {
	description = "The GitHub token"
	type        = string	
}