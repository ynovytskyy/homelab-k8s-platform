

# working on article part 2 istio installation


uninstalled existing, gathered logs of what's there (should have gathered more)


kubectl get all -n istio-ingress
NAME                                READY   STATUS    RESTARTS   AGE
pod/istio-ingress-75dd77777-chm8f   1/1     Running   0          35d

NAME                    TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                      AGE
service/istio-ingress   LoadBalancer   10.108.175.243   192.168.2.160   15021:30368/TCP,80:30664/TCP,443:30743/TCP   35d

NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/istio-ingress   1/1     1            1           35d

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/istio-ingress-75dd77777   1         1         1       35d

NAME                                                REFERENCE                  TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/istio-ingress   Deployment/istio-ingress   cpu: <unknown>/80%   1         5         1          35d


Resources for CRD: wasmplugins.extensions.istio.io
No resources found
----------------------------------------
Resources for CRD: authorizationpolicies.security.istio.io
No resources found
----------------------------------------
Resources for CRD: peerauthentications.security.istio.io
No resources found
----------------------------------------
Resources for CRD: requestauthentications.security.istio.io
No resources found
----------------------------------------
Resources for CRD: telemetries.telemetry.istio.io
No resources found
----------------------------------------
Resources for CRD: destinationrules.networking.istio.io
No resources found
----------------------------------------
Resources for CRD: envoyfilters.networking.istio.io
No resources found
----------------------------------------
Resources for CRD: gateways.networking.istio.io
NAMESPACE   NAME               AGE
dev-echo    external-gateway   31d
prod-echo   external-gateway   31d
----------------------------------------
Resources for CRD: proxyconfigs.networking.istio.io
No resources found
----------------------------------------
Resources for CRD: serviceentries.networking.istio.io
No resources found
----------------------------------------
Resources for CRD: sidecars.networking.istio.io
No resources found
----------------------------------------
Resources for CRD: virtualservices.networking.istio.io
NAMESPACE   NAME   GATEWAYS                         HOSTS                           AGE
dev-echo    echo   ["dev-echo/external-gateway"]    ["dev.api.example.com"]   31d
prod-echo   echo   ["prod-echo/external-gateway"]   ["api.example.com"]       31d
----------------------------------------
Resources for CRD: workloadentries.networking.istio.io
No resources found
----------------------------------------

