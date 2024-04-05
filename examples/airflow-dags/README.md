Run dags in airflow, copy dags python files into airflow scheduler pod with the following command  
`kubectl cp dags_file.py "airflow-scheduler-pod-name":/opt/airflow/dags -n airflow`