
```
docker build -t ubuntu-ssh:latest .  
minikube image load ubuntu-ssh
```
```
kubectl apply -f serviceaccounts/shell-sa.yaml
```
```
kubectl apply -f pods/ubuntu-ssh.yaml
```
```
kubectl apply -f pods/shell.yaml
```
```
kubectl apply -f ingress/shell-ingress.yaml 
```
```
echo $(minikube ip) dataplatform.shell.io | sudo tee -a /etc/hosts
```

__Terminal : http://dataplatform.shell.io/wetty__  
login : root  
password : root  

__Wetty__ : web browser based shell  
https://github.com/butlerx/wetty