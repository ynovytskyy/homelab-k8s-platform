

```shell
terraform init
terraform apply -var-file=moria.tfvars
mkdir ~/.kube
terraform output -raw kube_config > $HOME/.kube/config
kubectl get nodes

#talos
mkdir ~/.talos
terraform output -raw talos_config > $HOME/.talos/config
```
