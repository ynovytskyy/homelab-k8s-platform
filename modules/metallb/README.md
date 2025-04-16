
# MetalLB
READ this: https://metallb.io/configuration/#layer-2-configuration


### Useful commands
```shell
kubectl -n metallb-system get all
kubectl -n metallb-system get IPAddressPool     # to see the addresses
kubectl -n metallb-system get L2Advertisement   # to see the pool association
```


### Manual steps
```shell
kubectl create ns metallb-system
kubectl label namespace metallb-system pod-security.kubernetes.io/enforce=privileged

helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb \
  --namespace metallb-system

kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: metallb-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.2.160-192.168.2.169
EOF

kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2-advertisement
  namespace: metallb-system
spec:
  ipAddressPools:
  - metallb-pool
EOF
```
