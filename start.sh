#!/bin/bash

echo "Starting data plaform..."

helm repo add bitnami https://charts.bitnami.com/bitnami

# install tools
kubectl create namespace mysql
helm install mysql bitnami/mysql --namespace mysql
kubectl apply -f templates/phpmyadmin.yaml

kubectl create namespace spark
helm install spark bitnami/spark --namespace spark