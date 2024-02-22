#!/bin/bash

echo "Stopping data platform..."

# uninstall tools
helm uninstall mysql -n mysql
kubectl delete -f templates/phpmyadmin.yaml
kubectl delete namespace mysql

helm uninstall spark -n spark
kubectl delete namespace spark
