
## Install ArgoCD

https://argo-cd.readthedocs.io/en/stable/getting_started/#1-install-argo-cd

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

brew install argocd
kubectl config set-context --current --namespace=argocd

argocd admin initial-password -n argocd
argocd login localhost:8080

kubectl create namespace newns
kubectl label namespace newns istio-injection=enabled pod-security.kubernetes.io/enforce=privileged
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace newns
kubectl port-forward svc/argocd-server -n argocd 8080:443

argocd app get guestbook
argocd app sync guestbook

```