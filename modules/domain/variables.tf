variable "kubernetes_config" {
  type = object({
    host                   = string
    cluster_ca_certificate = string
    client_key             = string
    client_certificate     = string
  })
  description = "Kubernetes cluster configuration parameters"
}

variable "domain_name" {
  type        = string
  description = "Domain name to create (with namespaces per environment)"
}

variable "environments" {
  type        = list(string)
  description = "List of environments to create namespaces for"
  default     = ["dev", "prod"]
}
