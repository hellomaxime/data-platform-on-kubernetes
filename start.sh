#!/bin/bash

echo "Starting data plaform..."

# add repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add superset https://apache.github.io/superset
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

# install tools
kubectl create namespace mysql
kubectl apply -f kube_files/mysql.yaml
kubectl apply -f kube_files/phpmyadmin.yaml

kubectl create namespace spark
helm install spark bitnami/spark --namespace spark

helm upgrade --install --values values/superset-values.yaml superset superset/superset

helm upgrade --install --values values/jupyterhub-values.yaml jupyterhub jupyterhub/jupyterhub