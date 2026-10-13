output "istio_ingress_external_ip" {
  description = "The external IP address of the istio-ingress service."
  value       = data.kubernetes_service.istio_ingress.status[0].load_balancer[0].ingress[0].ip
}
