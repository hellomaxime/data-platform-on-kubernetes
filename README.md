# Data platform on Kubernetes

This project aims to deploy a complete data platform on kubernetes, many services are available to build end-to-end data engineering projects from ingestion to visualization. 

## Prerequisites
- docker
- kubernetes (minikube cluster for local development)
- kubectl
- helm

## Available services

- __Data integration__
    - Airbyte
- __Message queue__
    - Kafka
    - RabbitMQ
- __Database__
    - Cassandra
    - Druid
    - MongoDB
    - MySQL/Phpmyadmin
    - PostgreSQL
- __Datalake__
    - MinIO
- __Data transformation__
    - dbt
    - Flink
    - Spark
- __Visualization__
    - Superset
- __Orchestration__
    - Airflow
    - Argo Workflows
- __Monitoring__
    - Grafana/Prometheus
- __Notebook__
    - JupyterHub

## Data formats
- Delta Lake
- Apache Iceberg (soon)

## How to deploy the data platform on kubernetes

Before deploying in the cluster, choose the services you want to start in the `.config` file. (y|n)  

Start script : `./start.sh`  
Stop script : `./stop.sh`  

You may need to wait a few minutes for all services to start, you can check pods status with the following command : `kubectl get all -A`.  

Some services are accessible through an URL.  
example : `http://dataplatform.<service-name>.io/`
  
## Helpful:  

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