import pandas as pd
import mysql.connector
import clickhouse_connect

# MySQL Connection
mysql_conn = mysql.connector.connect(
    host="localhost",
    port=3306,
    user="root",
    password="root",
    database="ecommerce"
)

# ClickHouse Connection
CLICKHOUSE_HOSTNAME = 'localhost'
CLICKHOUSE_PORT = 8123
CLICKHOUSE_USER = 'default'
CLICKHOUSE_PASSWORD = 'default'

client = clickhouse_connect.get_client(
    host=CLICKHOUSE_HOSTNAME, port=CLICKHOUSE_PORT, username=CLICKHOUSE_USER, password=CLICKHOUSE_PASSWORD, database="ecommerce")

###

mysql_query = "SELECT * FROM users"

mysql_df = pd.read_sql(mysql_query, mysql_conn)

records = mysql_df.to_records(index=False)
values = list(records)

###

query = f"INSERT INTO users_dim VALUES {','.join(map(str, values))}"
client.command(query)

###

client.close()
mysql_conn.close()