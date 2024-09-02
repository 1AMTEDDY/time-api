output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  value = base64encode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

output "token" {
  value = data.google_client_config.default.access_token
}
