output "kube_config" {
  value = module.proxmox_talos.kube_config
  sensitive = true
}

output "talos_config" {
  value = module.proxmox_talos.talos_config
  sensitive = true
}

output "kube_client_config" {
  value = module.proxmox_talos.kube_client_config
  sensitive = true
}
