variable "proxmox_node_name" {
  type = string
}
variable "proxmox_admin_endpoint" {
  type = string
}
variable "proxmox_username" {
  type = string
}
variable "proxmox_password" {
  type = string
}
variable "proxmox_insecure" {
  type = bool
  default = false
}
variable "proxmox_vms_talos" {
  type = map(object({
    id     = number
    ip     = string
    controller = optional(bool)
  }))
}
variable "proxmox_vms_default_gateway" {
  type    = string
}

# get at https://factory.talos.dev/ depending on your needs for `systemExtensions`
# e.g. you'd want `siderolabs/qemu-guest-agent` when running Talos VMs on Proxmox
variable "talos_disk_image_schematic_id" {
  type   = string
}
# has to be in sync with the schematic id above
variable "talos_version" {
  type    = string
}
variable "talos_cluster_name" {
  type    = string
}
variable "talos_remove_cni" {
  type   = bool
  default = false
}
