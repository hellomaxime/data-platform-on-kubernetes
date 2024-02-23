#!/bin/bash

echo "Stopping data platform..."

# uninstall tools
kubectl delete -f kube_files/mysql.yaml
kubectl delete -f kube_files/phpmyadmin.yaml
kubectl delete namespace mysql

helm uninstall spark -n spark
kubectl delete namespace spark

helm uninstall superset

helm uninstall jupyterhub