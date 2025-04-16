
# Proxmox Talos Base
This module creates VMs and sets up a basic custom Talos-based Kubernetes cluster.


## Inputs
Followint inputs are used for Provider's connection to Proxmox:
`proxmox_node_name` name of the Proxmox node on which VMs are created and Talos image is downloaded;
`proxmox_admin_endpoint` URL like "https://192.168.1.10:8006/"
`proxmox_username` username@pam
`proxmox_password` password
`proxmox_insecure` to ignore TLS certificate checks

`talos_remove_cni` can be set `true` (`fasle` by default) to prevent installing 
Flannel CNI that comes with Talos out of the box.


## Outputs
TODO....


## TODO
* optionally create a virtual network and put all nodes into it
* make CPUs and memory of the VMs configurable - allow  workers to have more resources than controllers
