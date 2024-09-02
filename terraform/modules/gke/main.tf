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
}
