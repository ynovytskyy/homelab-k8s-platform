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

resource "kubernetes_namespace" "metallb-system" {
  metadata {
    name = "metallb-system"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
    }
  }
}

resource "helm_release" "metallb" {
  depends_on = [ kubernetes_namespace.metallb-system ]
  
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = "metallb-system"
  version    = var.metallb_version
}

resource "kubectl_manifest" "metallb_pool" {
  depends_on = [ helm_release.metallb ]

  yaml_body = yamlencode({
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata = {
      name      = "metallb-pool"
      namespace = "metallb-system"
    }
    spec = {
      addresses = [var.metallb_pool_addresses]
    }
  })

}

resource "kubectl_manifest" "metallb_l2_advertisement" {
  depends_on = [ kubectl_manifest.metallb_pool ]

  yaml_body = yamlencode({
    apiVersion = "metallb.io/v1beta1"
    kind       = "L2Advertisement"
    metadata = {
      name      = "l2-advertisement"
      namespace = "metallb-system"
    }
    spec = {
      ipAddressPools = ["metallb-pool"]
    }
  })
}
