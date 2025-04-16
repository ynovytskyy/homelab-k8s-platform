
```shell
kubectl apply -f service.yaml
export NGINX_IP=$(kubectl get svc nginx-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
curl http://$NGINX_IP

kubectl describe service/nginx-service
# should contain
# Events:
#   Type    Reason        Age   From                Message
#   ----    ------        ----  ----                -------
#   Normal  IPAllocated   119s  metallb-controller  Assigned IP ["192.168.2.160"]
#   Normal  nodeAssigned  17s   metallb-speaker     announcing from node "worker1" with protocol "layer2"
```
