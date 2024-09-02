resource "kubernetes_namespace" "api" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.api.metadata[0].name
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = "api"
      }
    }
    template {
      metadata {
        labels = {
          app = "api"
        }
      }
      spec {
        container {
          name  = var.container_name
          image = var.container_image
          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.api.metadata[0].name
  }
  spec {
    selector = {
      app = api
    }
    port {
      port        = var.service_port
      target_port = var.container_port
    }
    type = "LoadBalancer"
  }
}
