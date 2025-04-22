variable "kubernetes_config" {
  type = object({
    host                   = string
    cluster_ca_certificate = string
    client_key             = string
    client_certificate     = string
  })
  description = "Kubernetes cluster configuration parameters"
}

variable "environments" {
  type        = list(string)
  description = "List of environments to create ArgoCD applications for"
  default     = ["dev", "prod"]
}

variable "application_name" {
  type        = string
  description = "Base name of the ArgoCD application (will be suffixed with environment name)"
}

variable "application_repository_url" {
  type        = string
  description = "Git repository URL for the application"
}

variable "application_repository_path" {
  type        = string
  description = "Path within the repository where the Kubernetes manifests are located"
  default     = "deploy"
}

variable "target_revision" {
  type        = string
  description = "Target revision in the repository (branch, tag, or commit)"
  default     = "HEAD"
}

variable "destination_namespace" {
  type        = string
  description = "Target namespace for the application"
}

variable "destination_server" {
  type        = string
  description = "Target cluster server for the application"
  default     = "https://kubernetes.default.svc"
}
