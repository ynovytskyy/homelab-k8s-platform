module "proxmox_talos" {
  source = "./modules/proxmox_talos"

  proxmox_node_name = var.proxmox_node_name
  proxmox_admin_endpoint = var.proxmox_admin_endpoint
  proxmox_username = var.proxmox_username
  proxmox_password = var.proxmox_password
  proxmox_insecure = var.proxmox_insecure

  proxmox_vms_default_gateway = var.proxmox_vms_default_gateway
  proxmox_vms_talos = var.proxmox_vms_talos

  # https://factory.talos.dev/
  # 88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b = 1.9.5
  # customization:
  #     systemExtensions:
  #         officialExtensions:
  #             - siderolabs/iscsi-tools
  #             - siderolabs/qemu-guest-agent
  #             - siderolabs/util-linux-tools
  talos_disk_image_schematic_id = "88d1f7a5c4f1d3aba7df787c448c1d3d008ed29cfb34af53fa0df4336a56040b"
  talos_version = "v1.9.5"

  talos_cluster_name = "k8s-dev"
}

module "longhorn" {
  source = "./modules/longhorn"

  kube_host = module.proxmox_talos.kube_client_config.host
  kube_cluster_ca_certificate = module.proxmox_talos.kube_client_config.ca_certificate
  kube_client_key = module.proxmox_talos.kube_client_config.client_key
  kube_client_certificate = module.proxmox_talos.kube_client_config.client_certificate
  
  longhorn_version = "1.6.2"
}

module "metallb" {
  source = "./modules/metallb"

  kube_host = module.proxmox_talos.kube_client_config.host
  kube_cluster_ca_certificate = module.proxmox_talos.kube_client_config.ca_certificate
  kube_client_key = module.proxmox_talos.kube_client_config.client_key
  kube_client_certificate = module.proxmox_talos.kube_client_config.client_certificate

  metallb_version = "0.14.9"
  metallb_pool_addresses = var.metallb_pool_addresses # e.g. "192.168.1.100-192.168.1.199"
}
