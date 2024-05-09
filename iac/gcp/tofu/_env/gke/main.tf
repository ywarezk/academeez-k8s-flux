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
  default     = true
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

module "gke" {
  source             = "terraform-google-modules/kubernetes-engine/google"
  version            = "~> 30.0"
  name               = "gke-${var.name}"
  project_id         = var.project
  regional           = var.regional
  region             = var.region
  zones              = var.zones
  initial_node_count = var.initial_node_count
  network            = "default"
  subnetwork         = "default"
  ip_range_pods      = ""
  ip_range_services  = ""

  # terraform-google-modules/kubernetes-engine/google create a single node pool with preemptible nodes
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
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
}

output "gke" {
  sensitive = true
  value     = module.gke
}
