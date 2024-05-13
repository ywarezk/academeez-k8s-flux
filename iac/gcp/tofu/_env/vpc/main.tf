#
# Create vpc and subnets
#
# @author ywarezk
# @license MIT
# 

variable "name" {
	type = string
	description = "The name of the VPC"
}

variable "project" {
	type = string
	description = "The project id of the course project"
}

variable "region" {
	type = string
	description = "The region of the subnet"
}

module "vpc" {
	source  = "terraform-google-modules/network/google"
	version = "~> 9.1"
	network_name		= "vpc-${var.name}"
	project_id			= var.project	
	subnets = [
		{
			subnet_name = "subnet-${var.name}"
			subnet_ip = "10.0.0.0/17"
			subnet_region = var.region
		}
	]
	secondary_ranges = {
		"subnet-${var.name}" = [
			{
				range_name = "subnet-${var.name}-pods"
				ip_cidr_range = "192.168.0.0/18"
			},
			{
				range_name = "subnet-${var.name}-services"
				ip_cidr_range = "192.168.64.0/18"
			}
		]
	}
}

output "vpc" {
	value = module.vpc
}