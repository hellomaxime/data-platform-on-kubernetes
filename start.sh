#!/bin/bash

echo "Starting data plaform..."

# add repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add superset https://apache.github.io/superset
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo add apache-airflow https://airflow.apache.org
helm repo update

# install tools
kubectl create namespace mysql
kubectl apply -f deployments/mysql.yaml
kubectl apply -f deployments/phpmyadmin.yaml

kubectl create namespace spark
helm install spark bitnami/spark --namespace spark

kubectl create namespace superset
helm upgrade --install --values values/superset-values.yaml superset superset/superset --namespace superset

kubectl create namespace jupyterhub
helm upgrade --install --values values/jupyterhub-values.yaml jupyterhub jupyterhub/jupyterhub --namespace jupyterhub
kubectl apply -f ingress/jupyterhub-ingress.yaml

kubectl create namespace airflow
helm upgrade --install airflow apache-airflow/airflow --namespace airflow