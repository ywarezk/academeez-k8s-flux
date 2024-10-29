

terraform {
	required_version = "~> 1.8"
	required_providers {
		google = {
			version = "~> 6.8"
		}
		flux = {
			source = "fluxcd/flux"
			version = "~> 1.4"
		}
	}
}