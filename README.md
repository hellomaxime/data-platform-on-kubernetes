## data-platform-on-kubernetes

Prerequisites:
- minikube (local cluster for development)
- kubernetes cluster
- kubectl
- helm
- nginx ingress controller

Available services:
- Airflow
- Grafana/Prometheus
- JupyterHub
- Kafka
- MySQL/Phpmyadmin
- PostgreSQL
- Spark
- Superset

---

Before deploying in the cluster, choose the services you want to start in the `.config` file. (y|n)  

Start script : `./start.sh`  
Stop script : `./stop.sh`  

You may need to wait a few minutes for all services to start, you can check pods status with the following command : `kubectl get all -A`.  

Some services are accessible through an URL.  
example : `http://dataplatform.<service-name>.io/`

---  
  
Helpful:  

__access another service from inside__  
`<service-name>.<namespace>.svc.cluster.local:<service-port>`

__get helm default values__  
`helm show values <repo/chart> > values.yaml`  

__config file__  
set .config file to choose services you want to enable/disable

__minikube ingress addons__  
`minikube addons enable ingress`

__kubernetes dashboard__  
`minikube dashboard --url`