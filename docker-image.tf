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
}

resource "docker_image" "python_app" {
  name = "${var.docker_image_name}:latest"

  build {
    context    = "${path.root}"
    dockerfile = <<-DOCKERFILE
      FROM python:3.9-slim

      WORKDIR /app

      COPY requirements.txt .
      RUN pip install --no-cache-dir -r requirements.txt

      COPY . .

      RUN pip install --no-cache-dir pytest

      RUN pytest --disable-warnings

      EXPOSE 8080

      CMD ["python", "app.py"]
    DOCKERFILE
  }
}
resource "docker_registry_image" "python_app_registry" {
  name  = "${var.docker_registry}/${var.docker_image_name}:latest"
}
variable "docker_image_name" {
}
variable "docker_registry" {
  description = "Docker registry URL"
  default     = ""  # Replace with your Docker Hub username
}
