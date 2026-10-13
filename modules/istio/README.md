
## Install Istio
Basically following steps from  https://istio.io/latest/docs/setup/install/helm/ but in terraform code
```
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
helm install istiod istio/istiod -n istio-system --wait

kubectl get all -n istio-system
```

### Validation
```
helm ls -n istio-system
# should show
# NAME      	NAMESPACE   	REVISION	UPDATED	STATUS  	CHART        	APP VERSION
# istio-base	istio-system	1       	<date>	deployed	base-1.25.2  	1.25.2
# istiod    	istio-system	1       	<date> 	deployed	istiod-1.25.2	1.25.2

helm status istio-base -n istio-system
# check for: Istio base successfully installed!
helm status istiod -n istio-system
# check for: "istiod" successfully installed!

kubectl get deployments -n istio-system --output wide
```

## Install Istio Ingress
Following https://istio.io/latest/docs/setup/additional-setup/gateway/#deploying-a-gateway
but with extra label on the `istio-ingress` namespace.
```
kubectl create namespace istio-ingress
# doesn't help ??!!
kubectl label namespace istio-ingress pod-security.kubernetes.io/enforce=privileged
helm install istio-ingress istio/gateway -n istio-ingress --wait
```

### Validation for Ingress
```
helm ls -n istio-ingress
# NAME         	NAMESPACE    	REVISION	UPDATED	STATUS  	CHART         	APP VERSION
# istio-ingress	istio-ingress	1       	<date>	deployed	gateway-1.25.2	1.25.2

helm status istio-ingress -n istio-ingress
# check for: "istio-ingress" successfully installed!

kubectl get deployments -n istio-ingress --output wide
```

## Create gateway
Replace `api.example.com` with your domain, which must resolve to the `istio_ingress_external_ip` output.
In Terraform it is set via the `istio_external_gateway_host` variable.
```
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: external-gateway
  namespace: istio-ingress
spec:
  selector:
    istio: ingress
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - api.example.com
```
