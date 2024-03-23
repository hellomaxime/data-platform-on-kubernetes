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

users_query = "SELECT * FROM users"
users_df = pd.read_sql(users_query, mysql_conn)

records = users_df.to_records(index=False)
values = list(records)

query = f"INSERT INTO users_dim VALUES {','.join(map(str, values))}"
client.command(query)

###

products_query = "SELECT * FROM products"
products_df = pd.read_sql(products_query, mysql_conn)

records = products_df.to_records(index=False)
values = list(records)

query = f"INSERT INTO products_dim VALUES {','.join(map(str, values))}"
client.command(query)

###

orders_query = "SELECT order_id, order_date, total_amount FROM orders"
orders_df = pd.read_sql(orders_query, mysql_conn)

records = orders_df.to_records(index=False)
values = list(records)

query = f"INSERT INTO orders_dim VALUES {','.join(map(str, values))}"
client.command(query)

###

order_details_query = "SELECT * FROM order_details"
order_details_df = pd.read_sql(order_details_query, mysql_conn)

records = order_details_df.to_records(index=False)
values = list(records)

query = f"INSERT INTO order_details_dim VALUES {','.join(map(str, values))}"
client.command(query)

###

sales_query = """
    SELECT o.order_id, p.product_id, u.user_id, o.order_date, od.quantity as "quantity_sold", od.total_price as "total_amount"
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN users u ON o.user_id = u.user_id
    JOIN products p ON od.product_id = p.product_id;
"""
sales_df = pd.read_sql(sales_query, mysql_conn)

records = sales_df.to_records(index=False)
values = list(records)

query = f"INSERT INTO sales_fact VALUES {','.join(map(str, values))}"
client.command(query)

###

# Close connections
client.close()
mysql_conn.close()