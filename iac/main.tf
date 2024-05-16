
module "project" {
  source              = "terraform-google-modules/project-factory/google"
  version             = "~> 15.0"
  name                = var.project_name
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
  budget_amount = 30
}

# create vpc
module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 9.1"
  project_id   = module.project.project_id
  network_name = "vpc-gke"
  subnets = [
    {
      subnet_name   = "subnet-gke"
      subnet_ip     = "10.0.0.0/17"
      subnet_region = var.region
    }
  ]
  secondary_ranges = {
    "subnet-gke" = [
      {
        range_name    = "subnet-gke-pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "subnet-gke-services"
        ip_cidr_range = "192.168.64.0/18"
      }
    ]
  }
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google"
  version                         = "~> 30.0"
  name                            = "gke"
  project_id                      = module.project.project_id
  regional                        = false
  region                          = var.region
  zones                           = ["asia-southeast1-a"]
  initial_node_count              = 3
  network                         = module.vpc.network_name
  subnetwork                      = module.vpc.subnets_names[0]
  ip_range_pods                   = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services               = module.vpc.subnets_secondary_ranges[0][1].range_name
  deletion_protection             = false
  remove_default_node_pool        = true
  horizontal_pod_autoscaling      = false
  enable_vertical_pod_autoscaling = false

  # terraform-google-modules/kubernetes-engine/google create a single node pool with preemptible nodes
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      min_count          = 3
      max_count          = 3
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      preemptible        = true
      image_type         = "COS_CONTAINERD"
      autoscaling        = false
      initial_node_count = 3
      node_count         = 3
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}
    default-pool = {
      default-pool = true
    }
  }

  node_pools_taints = {
    all = []
    default-pool = [
      {
        key    = "default-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }
}

terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.3.0"
    }
  }
}


provider "flux" {
  kubernetes = {
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = []
      command     = "gke-gcloud-auth-plugin"
    }
    host                   = "https://${module.gke.endpoint}"
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
  git = {
    url = "https://github.com/${var.github_org}/${var.github_repository}.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = "${var.github_token}"
    }
  }
}

resource "flux_bootstrap_git" "bootstrap" {
  embedded_manifests = true
  path               = "clusters/test"
  components = [
    "source-controller", 
    "kustomize-controller", 
    "helm-controller", 
    "notification-controller"
  ]
}


