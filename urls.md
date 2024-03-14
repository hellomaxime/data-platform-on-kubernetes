Airbyte
- kubectl port-forward service/airbyte-airbyte-webapp-svc 8000:80 -n airbyte

Airflow
- http://dataplatform.airflow.io

Argo Workflows
- kubectl port-forward service/argo-server 2746:2746 -n argo

Cassandra
- username: cassandra, password: cassandra

ClickHouse
- kubectl port-forward svc/clickhouse 8123:8123 -n clickhouse
- username: default, password: default

Grafana
- http://dataplatform.grafana.io
- username: admin
- password: `kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode`

JupyterHub
- http://dataplatform.jupyterhub.io

Kubeflow  
- kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
- username : user@example.com, password: 12341234

MinIO
- http://dataplatform.minio.io
- username: admin
- password: `kubectl get secret --namespace minio minio -o jsonpath="{.data.root-password}" | base64 -d`

MySQL
- http://dataplatform.phpmyadmin.io
- username: root, password: root

PostgreSQL
- kubectl port-forward service/pgadmin-service 8080:80 -n postgresql
- username: postgres, password: password

Superset
- http://dataplatform.superset.io
- username: admin, password: admin