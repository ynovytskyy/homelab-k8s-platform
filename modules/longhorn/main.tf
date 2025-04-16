terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.kube_host
    cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
    client_key             = base64decode(var.kube_client_key)
    client_certificate     = base64decode(var.kube_client_certificate)
  }
}

provider "kubernetes" {
  host                   = var.kube_host
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
  client_key             = base64decode(var.kube_client_key)
  client_certificate     = base64decode(var.kube_client_certificate)
}

resource "kubernetes_namespace" "longhorn-system" {
  metadata {
    name = "longhorn-system"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "helm_release" "longhorn" {
  depends_on = [ kubernetes_namespace.longhorn-system ]
  name       = "longhorn"
  repository = "https://charts.longhorn.io/"
  chart      = "longhorn"
  namespace  = "longhorn-system"
  version    = var.longhorn_version
}
