`username="$(kubectl get secret hello-world-default-user -o jsonpath='{.data.username}' | base64 --decode)"`

`password="$(kubectl get secret hello-world-default-user -o jsonpath='{.data.password}' | base64 --decode)"`

`kubectl port-forward "service/hello-world" 5672`