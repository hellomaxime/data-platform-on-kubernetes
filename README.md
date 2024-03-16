# Data platform on Kubernetes

This project aims to deploy a complete data platform on kubernetes, many services are available to build end-to-end data engineering projects from ingestion to visualization. 

## Prerequisites
- docker
- kubernetes (minikube cluster for local development)
- kubectl
- helm

## Available services

- __Data ingestion__
    - Nifi
- __Data integration__
    - Airbyte
- __Message queue__
    - Kafka
    - RabbitMQ
- __Change Data Capture__
    - Debezium
- __Database__
    - Cassandra
    - Druid
    - MongoDB
    - MySQL/Phpmyadmin
    - PostgreSQL/pgAdmin
- __Data warehouse__
    - ClickHouse
- __Datalake__
    - MinIO
- __Data transformation__
    - dbt
    - Flink
    - Spark
- __Data quality__
    - Great Expectations
- __Distributed SQL query engine__
    - Trino
- __Visualization__
    - Superset
- __Machine learning__
    - Kubeflow
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

Before deploying in the cluster, choose services you want to start in `.config` file. (y|n)  

__(WIP) Option 1 : deploy using Terraform__  
`terraform init`  
`terraform apply`  

__Option 2 : deploy using scripts__  
`./start.sh`  

You may need to wait a few minutes for all services to start, you can check pods status with the following command : `kubectl get all -A`.  


__Turn off the data plaftorm__  
`terraform destroy` or `./stop.sh`  

## Helpful:  

__some services are accessible through an URL__  
example : `http://dataplatform.<service-name>.io/`

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