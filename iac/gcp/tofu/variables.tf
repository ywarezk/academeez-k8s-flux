

variable "billing_account" {
	description = "the gcp billing account that is connected to the project"
	type = string
}

variable "org_id" {
	description = "the gcp organization id"
	type = string
}

variable "project_id" {
	description = "academeez-k8s-flux created project id"
	type = string
}

variable "github_pat" {
	description = "The token used to talk to our github repo"
	type = string
}