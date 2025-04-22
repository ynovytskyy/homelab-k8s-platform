
# Longhorn storage for Talos
Talos doesn't come with K8s storage 
https://www.talos.dev/v1.9/kubernetes-guides/configuration/storage/

Longhorn is compatible with Talos, easy to install and manage storage for K8s
https://longhorn.io/docs/1.8.1/advanced-resources/os-distro-specific/talos-linux-support/

It requires that Talos contains system extentions to work with SCSI:
```yaml
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/iscsi-tools
            - siderolabs/util-linux-tools
```
Use https://factory.talos.dev/ to generate `schematic ID` used to download customized Talos image.


## Uninstallation
From here https://longhorn.io/docs/1.8.1/deploy/uninstall/#prerequisite

To prevent Longhorn from being accidentally uninstalled (which leads to data lost), we 
introduce a new setting, deleting-confirmation-flag. If this flag is false, the Longhorn 
uninstallation job will fail. Set this flag to true to allow Longhorn uninstallation. You 
can set this flag using setting page in Longhorn UI or 
```shell
kubectl -n longhorn-system patch -p '{"value": "true"}' --type=merge lhs deleting-confirmation-flag
```


### Todo
- put storage on a separate disk - that would require changes to how Talos VMs are set up


### Useful commands
```shell
kubectl -n longhorn-system port-forward svc/longhorn-frontend 8080:80
open http://localhost:8080
```
