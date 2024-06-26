#!/bin/bash

source ./.config

echo "Stopping data platform..."

# uninstall tools
if [[ $MYSQL == "y" ]]; then
    kubectl delete -f persistentvolumes/mysql.yaml
    kubectl delete -f deployments/mysql.yaml
    kubectl delete -f deployments/phpmyadmin.yaml
    kubectl delete -f ingress/phpmyadmin-ingress.yaml
    kubectl delete namespace mysql
fi

if [[ $SPARK == "y" ]]; then
    helm uninstall spark -n spark
    kubectl delete namespace spark
fi

if [[ $SUPERSET == "y" ]]; then
    helm uninstall superset -n superset
    kubectl delete -f ingress/superset-ingress.yaml
    kubectl delete namespace superset
fi

if [[ $JUPYTERHUB == "y" ]]; then
    helm uninstall jupyterhub -n jupyterhub
    kubectl delete -f ingress/jupyterhub-ingress.yaml
    kubectl delete namespace jupyterhub
fi

if [[ $AIRFLOW == "y" ]]; then
    helm uninstall airflow -n airflow
    kubectl delete -f ingress/airflow-ingress.yaml
    kubectl delete namespace airflow
fi

if [[ $KAFKA == "y" ]]; then
    kubectl delete -f ingress/kafka-ui-ingress.yaml
    helm uninstall kafka-ui -n kafka
    kubectl delete -f kubefiles/kafka-cluster.yaml -n kafka
    kubectl delete -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
    kubectl delete namespace kafka
fi

if [[ $GRAFANA == "y" ]]; then
    helm uninstall prometheus -n grafana
    helm uninstall grafana -n grafana
    kubectl delete -f ingress/grafana-ingress.yaml
    kubectl delete namespace grafana
fi

if [[ $POSTGRESQL == "y" ]]; then
    kubectl delete -f deployments/pgadmin.yaml
    kubectl delete -f ingress/pgadmin-ingress.yaml
    kubectl delete -f deployments/postgresql.yaml
    kubectl delete -f persistentvolumes/postgresql.yaml
    kubectl delete namespace postgresql
fi

if [[ $MINIO == "y" ]]; then
    helm uninstall minio -n minio
    kubectl delete -f ingress/minio-ingress.yaml
    kubectl delete namespace minio
fi

if [[ $MONGODB == "y" ]]; then
    kubectl delete -f ingress/mongoexpress-ingress.yaml
    kubectl delete -f deployments/mongoexpress.yaml
    kubectl delete -f deployments/mongodb.yaml
    kubectl delete namespace mongodb
fi

if [[ $ARGOWORKFLOWS == "y" ]]; then
    kubectl delete -f ingress/argoworkflows-ingress.yaml
    kubectl delete -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.4/quick-start-minimal.yaml
    kubectl delete namespace argo
fi

if [[ $DRUID == "y" ]]; then
    kubectl delete -f ingress/druid-ingress.yaml
    kubectl delete -f kubefiles/druid-cluster.yaml -n druid-operator-system
    kubectl delete -f kubefiles/druid-zk-cluster.yaml -n druid-operator-system
    helm uninstall cluster-druid-operator -n druid-operator-system
    kubectl delete namespace druid-operator-system
fi

if [[ $AIRBYTE == "y" ]]; then
    kubectl delete -f ingress/airbyte-ingress.yaml
    helm uninstall airbyte -n airbyte
    kubectl delete namespace airbyte
fi

if [[ $FLINK == "y" ]]; then
    helm uninstall flink-kubernetes-operator
fi

if [[ $RABBITMQ == "y" ]]; then
    kubectl delete -f kubefiles/rabbitmq-cluster.yaml
    helm uninstall rabbitmq
fi

if [[ $CASSANDRA == "y" ]]; then
    helm uninstall cassandra -n cassandra
    kubectl delete namespace cassandra
fi

if [[ $TRINO == "y" ]]; then
    helm uninstall trino-cluster -n trino
    kubectl delete namespace trino
fi

if [[ $DEBEZIUM == "y" ]]; then
    kubectl delete -f kubefiles/debezium-kafkaconnect.yaml
fi

if [[ $KUBEFLOW == "y" ]]; then
    cd manifests
    kubectl kustomize example | kubectl delete -f -
    cd ..
    rm -rf manifests
fi

if [[ $CLICKHOUSE == "y" ]]; then
    helm uninstall clickhouse -n clickhouse
    kubectl delete namespace clickhouse
fi

if [[ $NIFI == "y" ]]; then
    kubectl delete -f ingress/nifi-ingress.yaml
    helm uninstall nifi -n nifi
    kubectl delete namespace nifi
fi

if [[ $METABASE == "y" ]]; then
    kubectl delete -f deployments/metabase.yaml
    kubectl delete -f ingress/metabase-ingress.yaml
    kubectl delete namespace metabase
fi