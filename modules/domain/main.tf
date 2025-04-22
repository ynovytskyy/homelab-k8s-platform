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

resource "kubernetes_namespace" "namespace_prod" {
  metadata {
    name = "prod-${var.domain_name}"
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "environment" = "prod"
      "istio-injection" = "enabled"
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "kubernetes_namespace" "namespace_dev" {
  metadata {
    name = "dev-${var.domain_name}"
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "environment" = "dev"
      "istio-injection" = "enabled"
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}
