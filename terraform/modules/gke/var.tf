variable "project_id" {}
variable "cluster_name" {}
variable "region" {}
variable "network_name" {}
variable "subnetwork_name" {}
variable "ip_range_pods" {}
variable "ip_range_services" {}
variable "node_pool_tags" {
  default = "gke-api-nodes"
}
//variable "enable_private_endpoint" { default = true }
//variable "enable_private_nodes" { default = true }
