#!/bin/bash

echo "Stopping data platform..."

# uninstall tools
kubectl delete -f deployments/mysql.yaml
kubectl delete -f deployments/phpmyadmin.yaml
kubectl delete namespace mysql

helm uninstall spark -n spark
kubectl delete namespace spark

helm uninstall superset
kubectl delete namespace superset

helm uninstall jupyterhub
kubectl delete namespace jupyterhub

helm uninstall airflow
kubectl delete namespace airflow