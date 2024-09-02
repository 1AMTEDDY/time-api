output "gke_cluster_name" {
  value = module.gke.name
}

output "gke_cluster_endpoint" {
  value = module.gke.endpoint
}
output "gke_cluster_ca_certificate" {
  value = module.gke.master_auth[0].cluster_ca_certificate
}
output "token" {
  value = data.google_client_config.default.access_token
}
