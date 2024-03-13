Connect to trino  
SQLAlchemy URI : `trino://trino@trino-cluster.trino.svc.cluster.local:8080/<catalog>`

Database driver missing in superset image  
`pip install sqlalchemy-trino`  

---

Connect to ClickHouse  
SQLAlchemy URI : `clickhousedb://default:default@clickhouse.clickhouse.svc.cluster.local:8123/default`

Database driver missing in superset image  
`pip install clickhouse-connect`  