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
  type = string
}
variable "metallb_pool_addresses" {
  type = string
}
