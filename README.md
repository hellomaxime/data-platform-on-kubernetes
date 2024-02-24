## data-platform-on-kubernetes

Prerequisites:
- kubernetes cluster
- kubectl
- helm

Available services:
- Airflow
- JupyterHub
- Kafka
- MySQL/Phpmyadmin
- Spark
- Superset

---  
  
Helpful:  

__access another service from inside__  
`<service-name>.<namespace>.svc.cluster.local:<service-port>`

__get helm default values__  
`helm show values <repo/chart> > values.yaml`  

__config file__  
set .config file to choose services you want to enable/disable