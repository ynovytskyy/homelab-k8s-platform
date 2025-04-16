## HomeLab Kubernetes Platform with a single Terraform apply

<img src="https://github.com/user-attachments/assets/d16c737e-9d19-42d7-b527-623f89fc9cd8" height="600"/>

Proxmox-based HomeLab setup to reach Kubernetes as a Platform abstraction level as efficiently and 
reproduceably as possible - with a single terraform apply command. 

```shell
terraform init
terraform apply -var-file=example.tfvars
mkdir ~/.kube
terraform output -raw kube_config > $HOME/.kube/config
kubectl get nodes

#talos
mkdir ~/.talos
terraform output -raw talos_config > $HOME/.talos/config
```

**Phase 1:** Using Proxmox, Talos (Kubernetes with Flannel), Longhorn, and MetalLB.

**Phase 2:** (wip) Adding Istio, Ingress, and ArgoCD.

**Phase 3:** (future) Observability with Grafana stack; Cilium branch of the setup.
