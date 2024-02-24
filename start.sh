#!/bin/bash

source ./.config

echo "Starting data plaform..."

# add repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add superset https://apache.github.io/superset
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo add apache-airflow https://airflow.apache.org
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