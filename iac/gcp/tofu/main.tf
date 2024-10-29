/**
 * In this OpenTofu/Terraform example we will install Flux on our GKE cluster.
 * we will do the following:
 * 1. Create a GCP project
 * 2. Create a VPC and subnet
 * 3. Create a GKE cluster
 * 4. Install Flux on the GKE cluster
 *
 * Created October 29, 2024
 * @author ywarezk
 */

/**
 * With the google provider we can use terrafom to create resources in GCP
 */
provider "google" {  
  user_project_override = true
	project               = var.project_id
  billing_project       = var.project_id
}

/**
 * The terraform-google-modules is a collection of terraform modules that help us create resources in GCP
 * We will use terraform-google-modules/project-factory/google to create our GCP Project
 */
module "project" {
	source = "terraform-google-modules/project-factory/google"
	version = "~> 17.0"
	auto_create_network = false	
	billing_account = var.billing_account
	org_id = var.org_id
	budget_amount = 30
	name = "academeez-k8s-flux"
	random_project_id = true
	create_project_sa = false
	deletion_policy = "ABANDON"
	activate_apis = [
		"compute.googleapis.com",
		"billingbudgets.googleapis.com",
		"cloudresourcemanager.googleapis.com",
		"serviceusage.googleapis.com",	
		"container.googleapis.com"	
	]
}

/**
 * We will place our application in a single VPC.
 * We will also create a subnet to place our GKE cluster in.
 */ 
module "vpc" {
	source  = "terraform-google-modules/network/google"
	version = "~> 9.3"

	project_id   = module.project.project_id
	network_name = "academeez-k8s-flux"
	routing_mode = "GLOBAL"

	subnets = [
		{
				subnet_name           = "k8s"
				subnet_ip             = "10.0.0.0/24"
				subnet_region         = "us-central1"
		}
	]
	
	secondary_ranges = {
		k8s = [
			{
				range_name    = "pods"
				ip_cidr_range = "10.1.0.0/16"
			},
			{
				range_name    = "services"
				ip_cidr_range = "10.2.0.0/24"
			}
		]
	}
	
}

/**
 * This will create our managed kubernetes cluster
 */
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
	version                    = "~> 33.1"
	project_id = module.project.project_id
	name = "academeez-k8s-flux"
	region = "us-central1"
	zones = ["us-central1-a", "us-central1-b", "us-central1-f"]
	network = module.vpc.network_name
	subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services          = module.vpc.subnets_secondary_ranges[0][1].range_name
	deletion_protection = false
	node_pools = [
		{
			name                        = "default-node-pool"
			machine_type                = "e2-medium"
			node_locations              = "us-central1-a,us-central1-b,us-central1-f"
			min_count                   = 1
      max_count                   = 10
			initial_node_count          = 3
		}
	]
	
	node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

/**
 * Configuring the flux provider will allow us to install flux in our cluster
 * we need to authenticate the flux provider with our GKE cluster and with our github repo
 */
provider "flux" {
	kubernetes = {
		host = module.gke.endpoint
		cluster_ca_certificate = base64decode(module.gke.ca_certificate)
		exec = {
			api_version = "client.authentication.k8s.io/v1beta1"
			command = "gke-gcloud-auth-plugin"
		}
	}
	git = {
    url = "https://github.com/ywarezk/academeez-k8s-flux.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = var.github_pat
    }
  }
}

/**
 * This will install flux on our GKE cluster
 */
resource "flux_bootstrap_git" "flux_test_cluster" {
	path = "clusters/prod"	
}