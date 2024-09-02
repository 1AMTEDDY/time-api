output "service_url" {
  value = kubernetes_service.api_service.status[0].load_balancer[0].ingress[0].ip
}
