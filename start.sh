#!/bin/bash

source ./.config

echo "Starting data plaform..."

# add repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add superset https://apache.github.io/superset
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo add apache-airflow https://airflow.apache.org
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add datainfra https://charts.datainfra.io
helm repo add airbyte https://airbytehq.github.io/helm-charts
helm repo add flink-operator-repo https://downloads.apache.org/flink/flink-kubernetes-operator-1.7.0/
helm repo add trino https://trinodb.github.io/charts
helm repo update

# install tools
if [[ $MYSQL == "y" ]]; then
    kubectl create namespace mysql
    kubectl apply -f deployments/mysql.yaml
    kubectl apply -f deployments/phpmyadmin.yaml
    kubectl apply -f ingress/phpmyadmin-ingress.yaml
    echo "update /etc/hosts : dataplatform.phpmyadmin.io"
    echo $(minikube ip) dataplatform.phpmyadmin.io | sudo tee -a /etc/hosts
fi

if [[ $SPARK == "y" ]]; then
    kubectl create namespace spark
    helm install spark bitnami/spark --namespace spark
fi

if [[ $SUPERSET == "y" ]]; then
    kubectl create namespace superset
    helm upgrade --install --values values/superset-values.yaml superset superset/superset --namespace superset
    kubectl apply -f ingress/superset-ingress.yaml
    echo "update /etc/hosts : dataplatform.superset.io"
    echo $(minikube ip) dataplatform.superset.io | sudo tee -a /etc/hosts
fi

if [[ $JUPYTERHUB == "y" ]]; then
    kubectl create namespace jupyterhub
    helm upgrade --install --values values/jupyterhub-values.yaml jupyterhub jupyterhub/jupyterhub --namespace jupyterhub
    kubectl apply -f ingress/jupyterhub-ingress.yaml
    echo "update /etc/hosts : dataplatform.jupyterhub.io"
    echo $(minikube ip) dataplatform.jupyterhub.io | sudo tee -a /etc/hosts
fi

if [[ $AIRFLOW == "y" ]]; then
    kubectl create namespace airflow
    helm upgrade --install airflow apache-airflow/airflow --namespace airflow
    kubectl apply -f ingress/airflow-ingress.yaml
    echo "update /etc/hosts : dataplatform.airflow.io"
    echo $(minikube ip) dataplatform.airflow.io | sudo tee -a /etc/hosts
fi

if [[ $KAFKA == "y" ]]; then
    kubectl create namespace kafka
    kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
    kubectl apply -f kubefiles/kafka-cluster.yaml -n kafka
    kubectl wait kafka/kafka-cluster --for=condition=Ready --timeout=600s -n kafka
    kubectl apply -f kubefiles/kafka-topic.yaml -n kafka
fi

if [[ $GRAFANA == "y" ]]; then
    helm install prometheus prometheus-community/prometheus
    helm install grafana grafana/grafana
    kubectl apply -f ingress/grafana-ingress.yaml
    echo "update /etc/hosts : dataplatform.grafana.io"
    echo $(minikube ip) dataplatform.grafana.io | sudo tee -a /etc/hosts
fi

if [[ $POSTGRESQL == "y" ]]; then
    kubectl create namespace postgresql
    kubectl apply -f persistentvolumes/postgresql.yaml
    kubectl apply -f deployments/postgresql.yaml
    kubectl apply -f deployments/pgadmin.yaml
fi

if [[ $MINIO == "y" ]]; then
    kubectl create namespace minio
    helm install minio bitnami/minio -n minio
    kubectl apply -f ingress/minio-ingress.yaml
    echo "update /etc/hosts : dataplatform.minio.io"
    echo $(minikube ip) dataplatform.minio.io | sudo tee -a /etc/hosts
fi

if [[ $MONGODB == "y" ]]; then
    kubectl create namespace mongodb
    kubectl apply -f persistentvolumes/mongodb.yaml
    kubectl apply -f deployments/mongodb.yaml
fi

if [[ $ARGOWORKFLOWS == "y" ]]; then
    kubectl create namespace argo
    kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.4/quick-start-minimal.yaml
fi

if [[ $DRUID == "y" ]]; then
    kubectl create namespace druid-operator-system
    helm upgrade -i cluster-druid-operator datainfra/druid-operator -n druid-operator-system
    kubectl apply -f kubefiles/druid-zk-cluster.yaml -n druid-operator-system
    kubectl apply -f kubefiles/druid-cluster.yaml -n druid-operator-system
fi

if [[ $AIRBYTE == "y" ]]; then
    kubectl create namespace airbyte
    helm install airbyte airbyte/airbyte -n airbyte
fi

if [[ $FLINK == "y" ]]; then
    kubectl create -f https://github.com/jetstack/cert-manager/releases/download/v1.8.2/cert-manager.yaml
    helm install flink-kubernetes-operator flink-operator-repo/flink-kubernetes-operator --set webhook.create=false
fi

if [[ $RABBITMQ == "y" ]]; then
    helm install rabbitmq bitnami/rabbitmq-cluster-operator
    kubectl apply -f kubefiles/rabbitmq-cluster.yaml
fi

if [[ $CASSANDRA == "y" ]]; then
    kubectl create namespace cassandra
    helm install --values values/cassandra-values.yaml cassandra bitnami/cassandra -n cassandra
fi

if [[ $TRINO == "y" ]]; then
    kubectl create namespace trino
    helm install -f values/trino-catalogs.yaml trino-cluster trino/trino -n trino
fi

if [[ $DEBEZIUM == "y" ]]; then
    kubectl apply -f kubefiles/debezium-kafkaconnect.yaml
fi

if [[ $KUBEFLOW == "y" ]]; then
    git clone https://github.com/kubeflow/manifests.git
    cd manifests
    while ! kubectl kustomize example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
    cd ..
fi