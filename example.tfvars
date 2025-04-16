proxmox_node_name = "altair"
proxmox_admin_endpoint = "https://192.168.1.10:8006/"
proxmox_username = "admin@pam"
proxmox_password = "secret"
proxmox_insecure = true

proxmox_vms_default_gateway = "192.168.1.1"
proxmox_vms_talos = {
  controller1 = {
    id   = 100
    ip   = "192.168.1.100/24"
    controller = true
  }
  worker1 = {
    id   = 110
    ip   = "192.168.1.110/24"
  }
  worker2 = {
    id   = 111
    ip   = "192.168.1.111/24"
  }
}

metallb_pool_addresses = "192.168.1.180-192.168.2.199"
