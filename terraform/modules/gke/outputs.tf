output "gke_cluster_name" {
  value = module.gke.name
}

output "gke_cluster_endpoint" {
  value = module.gke.endpoint
}
