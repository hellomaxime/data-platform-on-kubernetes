from datetime import datetime


from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'maxime',
    'retries': '5',
    'retry_delay': timedelta(minutes=2)
}

with DAG(
    dag_id='our_first_dag',
    default_args=default_args,
    description='This is our first dag that we write',
    start_date=datetime(2024, 4, 5, 1),
    schedule_interval='@daily'
) as dag:
    task1 = BashOperator(
        task_id='first_task',
        bash_command='echo hello world, this is the first task!'
    )

    task2 = BashOperator(
        task_id='second_task',
        bash_command='echo hello world, this is the second task!'
    )

    task3 = BashOperator(
        task_id='third_task',
        bash_command='echo hello world, this is the third task!'
    )

    task4 = BashOperator(
        task_id='fourth_task',
        bash_command='echo hello world, this is the fourth task!'
    )

    task1 >> [task2, task3]
    task3 >> task4