variable "project_id" {}
variable "container_image" {}
variable "region" { default = "us-central1" }
variable "network_name" { default = "vpc-network" }
variable "subnetwork_name" { default = "subnet-1" }
variable "subnet_cidr" { default = "10.0.0.0/24" }
variable "cluster_name" { default = "gke-cluster" }
variable "ip_range_pods" { default = "10.4.0.0/14" }
variable "ip_range_services" { default = "10.4.0.0/14" }
variable "roles" {
  type = map(object({
    role   = string
    member = string
  }))
}
