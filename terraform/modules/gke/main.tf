data "google_client_config" "default" {
  depends_on = [module.gke]
}
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
  }
}
provider "kubernetes" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}
data "google_container_cluster" "default" {
  name       = var.cluster_name
  depends_on = [module.gke]
}
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 18.0"

  project_id     = var.project_id
  name           = var.cluster_name
  region         = var.region
  network        = var.network_name
  subnetwork     = var.subnetwork_name
  ip_range_pods  = var.ip_range_pods
  ip_range_services = var.ip_range_services

  # Enable Cloud Monitoring and Logging
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  logging_service    = "logging.googleapis.com/kubernetes"
  node_pools = [
    {
      name               = "default-pool"
      machine_type       = "e2-medium"
      min_count          = 1
      max_count          = 3
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      auto_upgrade       = true
      auto_repair        = true
      tags               = var.node_pool_tags
      preemptible        = false
      initial_node_count = 1
      image_type         = "COS_CONTAINERD"
    }
  ]
}

