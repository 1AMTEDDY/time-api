terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}
provider "docker" {
  host = "unix:///var/run/docker.sock"
  registry_auth {
    address  = "registry-1.docker.io"
    username = var.docker_username
    password = var.docker_password
  }
}

resource "docker_image" "python_app" {
  name = "${var.docker_image_name}:latest"

  build {
    context    = "${path.root}"
    dockerfile = "Dockerfile"
  }
}
resource "docker_registry_image" "python_app_registry" {
  name  = "${var.docker_registry_name}/${var.docker_image_name}:latest"
}

variable "docker_image_name" {
}
variable "docker_registry_name" {
  description = "Docker registry URL"
  default     = ""  # Replace with your Docker Hub username
}


variable "docker_registry" {
  default = "docker.io"
}

variable "docker_username" {
  description = "Docker registry username"
}

variable "docker_password" {
  description = "Docker registry password"
}
