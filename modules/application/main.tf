terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "kubernetes" {
  host                   = var.kubernetes_config.host
  cluster_ca_certificate = base64decode(var.kubernetes_config.cluster_ca_certificate)
  client_key             = base64decode(var.kubernetes_config.client_key)
  client_certificate     = base64decode(var.kubernetes_config.client_certificate)
}

resource "kubernetes_manifest" "argocd_application" {
  for_each = toset(var.environments)

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "${var.application_name}-${each.value}"
      namespace = "argocd"
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
        "environment"                  = each.value
      }
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.application_repository_url
        path          = var.application_repository_path
        targetRevision = var.target_revision
      }
      destination = {
        namespace = "${var.destination_namespace}-${each.value}"
        server    = var.destination_server
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
          allowEmpty = false
        }
        syncOptions = ["PruneLast=true"]
      }
    }
  }
} 