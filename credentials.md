Airbyte
- http://dataplatform.airbyte.io

Airflow
- http://dataplatform.airflow.io
- username: admin, password: admin  

Argo Workflows
- https://dataplatform.argoworkflows.io/

Cassandra
- username: cassandra, password: cassandra

ClickHouse
- kubectl port-forward svc/clickhouse 8123:8123 -n clickhouse
- username: default, password: default

Druid
- create "druid" database in postgresql
- http://dataplatform.druid.io

Grafana
- http://dataplatform.grafana.io
- username: admin
- password: `kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode`

JupyterHub
- http://dataplatform.jupyterhub.io

Kafka
- http://dataplatform.kafka-ui.io

Kubeflow  
- kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
- username : user@example.com, password: 12341234

Metabase
- http://dataplatform.metabase.io

MinIO
- http://dataplatform.minio.io
- username: admin
- password: `kubectl get secret --namespace minio minio -o jsonpath="{.data.root-password}" | base64 -d`

MongoDB
- http://dataplatform.mongoexpress.io
- username: admin, password: pass

MySQL
- http://dataplatform.phpmyadmin.io
- username: root, password: root

Nifi
- https://dataplatform.nifi.io
- username: username, password: nifipassword

PgAdmin
- http://dataplatform.pgadmin.io
- username: admin@admin.com, password: password

PostgreSQL
- username: postgres, password: password

Superset
- http://dataplatform.superset.io
- username: admin, password: admin