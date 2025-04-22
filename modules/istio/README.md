
## Install Istio

```
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace

kubectl get ns
kubectl get all -n istio-system

helm ls -n istio-system
```

install Istio CNI now? https://istio.io/latest/docs/setup/additional-setup/cni/#installing-with-helm


helm install istiod istio/istiod -n istio-system --wait
helm status istiod -n istio-system


kubectl create namespace istio-ingress
# doesn't help --> kubectl label namespace istio-ingress pod-security.kubernetes.io/enforce=privileged
helm install istio-ingress istio/gateway -n istio-ingress --wait

kubectl get Gateway -A
