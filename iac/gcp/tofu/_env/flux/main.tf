#
# Terraform module for bootstrapping flux on the cluster
#
# Created May 13th, 2024
# @author ywarezk
# @license MIT
#

terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.3.0"
    }
  }
}

variable "env" {
	type        = string
	description = "The environment of the cluster"
}

resource "flux_bootstrap_git" "bootstrap" {
  embedded_manifests = true
  path               = "clusters/${var.env}"
}