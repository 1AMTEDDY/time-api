terraform {
  backend "gcs" {
    // statefile
    bucket  = "timer-api-bucket"
    prefix  = "terraform/state"
    credentials = "/home/runner/gcloud_key.json"
  }
}


provider "google" {
  credentials = file("/home/runner/gcloud_key.json")
  project     = var.project_id
  region      = var.region
}

module "network" {
  source           = "./modules/network"
  network_name     = var.network_name
  subnetwork_name  = var.subnetwork_name
  subnet_cidr      = var.subnet_cidr
  region           = var.region
  router_name      = "nat-router"
  nat_name         = "nat-gateway"
  ip_range_pods = var.ip_range_pods
  ip_range_services = var.ip_range_services
}

module "gke" {
  source             = "./modules/gke"
  project_id         = var.project_id
  cluster_name       = var.cluster_name
  region             = var.region
  network_name       = module.network.network_name
  subnetwork_name    = module.network.subnetwork_name
  ip_range_pods      = "pods-range"
  ip_range_services  = "services-range"
  node_pool_tags    = "gke-api-nodes"
}

module "iam" {
  source    = "./modules/iam"
  project_id = var.project_id
  roles      = var.roles
}

module "kubernetes" {
  source         = "./modules/k8s"
  namespace_name = "api"
  deployment_name = "api-deployment"
  container_name = "api"
  container_image = var.container_image
  container_port = 8080
  replicas       = 2
  service_name   = "api-service"
  service_port   = 80
  depends_on = [module.gke]
}

