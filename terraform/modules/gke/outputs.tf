output "gke_cluster_name" {
  value = module.gke.name
}

output "gke_cluster_endpoint" {
  value = module.gke.endpoint
  sensitive = true
}
output "gke_cluster_ca_certificate" {
  value = module.gke.ca_certificate
}
output "token" {
  value = data.google_client_config.default.access_token
  sensitive = true
}
