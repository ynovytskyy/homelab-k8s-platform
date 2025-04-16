output "talos_config" {
  value = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kube_config" {
  value = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

output "kube_client_config" { 
  value = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration  
  sensitive = true
}
