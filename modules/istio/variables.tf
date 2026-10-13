variable "kube_host" {
  type        = string
}
variable "kube_cluster_ca_certificate" {
  type        = string
}
variable "kube_client_key" {
  type        = string
}
variable "kube_client_certificate" {
  type        = string
}

variable "istio_version" {
  type        = string
  description = "Istio chart version to install (e.g., 1.26.0)"
}
variable "istio_external_gateway_host" {
  type        = string
  description = "Gateway host"
}
