#!/bin/bash

source ./.config

echo "Stopping data platform..."

# uninstall tools
if [[ $MYSQL == "y" ]]; then
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
    kubectl delete -f kubefiles/kafka-topic.yaml -n kafka
    kubectl delete -f kubefiles/kafka-cluster.yaml -n kafka
    kubectl delete -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
    kubectl delete namespace kafka
fi

if [[ $GRAFANA == "y" ]]; then
    helm uninstall prometheus
    helm uninstall grafana
    kubectl delete -f ingress/grafana-ingress.yaml
fi

if [[ $POSTGRESQL == "y" ]]; then
    helm uninstall postgresql -n postgresql
    kubectl delete namespace postgresql
fi

if [[ $MINIO == "y" ]]; then
    helm uninstall minio -n minio
    kubectl delete -f ingress/minio-ingress.yaml
    kubectl delete namespace minio
fi

if [[ $MONGODB == "y" ]]; then
    kubectl delete -f deployments/mongodb.yaml
    kubectl delete namespace mongodb
fi

if [[ $ARGOWORKFLOWS == "y" ]]; then
    kubectl delete -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.4/quick-start-minimal.yaml
    kubectl delete namespace argo
fi