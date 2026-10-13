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
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
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

provider "kubectl" {
  load_config_file       = false
  host                   = var.kube_host
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
  client_key             = base64decode(var.kube_client_key)
  client_certificate     = base64decode(var.kube_client_certificate)
}

resource "helm_release" "istio_base" {
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  namespace  = "istio-system"
  version    = var.istio_version
  create_namespace = true
  wait             = true
  set {
    name  = "defaultRevision"
    value = "default"
  }
}

resource "helm_release" "istiod" {
  depends_on = [helm_release.istio_base]
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  namespace  = "istio-system"
  version    = var.istio_version
  wait       = true
}

resource "kubernetes_namespace" "istio_ingress" {
  metadata {
    name = "istio-ingress"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "helm_release" "istio_ingress" {
  depends_on = [kubernetes_namespace.istio_ingress, helm_release.istiod]
  name       = "istio-ingress"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  namespace  = "istio-ingress"
  version    = var.istio_version
  wait       = true
}

resource "kubectl_manifest" "istio_external_gateway" {
  depends_on = [helm_release.istio_ingress]
  yaml_body = yamlencode({
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "Gateway"
    metadata = {
      name      = "external-gateway"
      namespace = "istio-ingress"
    }
    spec = {
      selector = {
        istio = "ingress"
      }
      servers = [
        {
          port = {
            number   = 80
            name     = "http"
            protocol = "HTTP"
          }
          hosts = [var.istio_external_gateway_host]
        }
      ]
    }
  })
}

data "kubernetes_service" "istio_ingress" {
  metadata {
    name      = "istio-ingress"
    namespace = "istio-ingress"
  }
} 