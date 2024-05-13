# 
# Module for creating the common entries for gke
#
# Created May 7th, 2024
# @author ywarezk
# @license MIT
# 

variable "project" {
  type        = string
  description = "The project id of the course project"
}

variable "regional" {
  type        = bool
  description = "If true, the GKE cluster will be regional"
}

variable "region" {
  type        = string
  description = "The region of the GKE cluster"
}

variable "zones" {
  type        = list(string)
  description = "The zones of the GKE cluster"
}

variable "initial_node_count" {
  type        = number
  description = "The initial node count of the GKE cluster"
}

variable "name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "min_node_count" {
  type        = number
  description = "The minimum node count of the GKE cluster"
  default     = 1
}

variable "max_node_count" {
  type        = number
  description = "The maximum node count of the GKE cluster"
  default     = 1
}

variable "preemptible" {
  type        = bool
  description = "If true, the nodes will be preemptible"
  default     = false
}

variable "autoscaling" {
  type        = bool
  description = "If true, the nodes will autoscale"
  default     = false
}

variable "spot" {
  type        = bool
  description = "If true, the nodes will be spot instances"
  default     = true
}

variable "network" {
  type        = string
  description = "The network of the GKE cluster"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork of the GKE cluster"
}

variable "subnets_secondary_ranges" {
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  description = "The secondary ranges of the GKE cluster"
}

variable "machine_type" {
  type        = string
  description = "The machine type of the GKE cluster"
  default     = "e2-medium"
}

module "gke" {
  source              = "terraform-google-modules/kubernetes-engine/google"
  version             = "~> 30.0"
  name                = "gke-${var.name}"
  project_id          = var.project
  regional            = var.regional
  region              = var.region
  zones               = var.zones
  initial_node_count  = var.initial_node_count
  network             = var.network
  subnetwork          = var.subnetwork
  ip_range_pods       = var.subnets_secondary_ranges[0].range_name
  ip_range_services   = var.subnets_secondary_ranges[1].range_name
  deletion_protection = false

  # terraform-google-modules/kubernetes-engine/google create a single node pool with preemptible nodes
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.min_node_count
      max_count          = var.max_node_count
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      preemptible        = var.preemptible
      spot               = var.spot
      image_type         = "COS_CONTAINERD"
      autoscaling        = var.autoscaling
      initial_node_count = var.initial_node_count
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
    default-node-pool = {
      default-node-pool = true
    }
  }  

  node_pools_taints = {
    all = []
    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }  
}

output "gke" {
  sensitive = true
  value     = module.gke
}
