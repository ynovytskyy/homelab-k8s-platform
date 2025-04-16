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

variable "metallb_version" {
  type        = string
}
variable "metallb_pool_addresses" {
  type = string
}
