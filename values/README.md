Connect to trino  
SQLAlchemy URI : `trino://trino@trino-cluster.trino.svc.cluster.local:8080/<catalog>`

Database driver missing in superset image  
`pip install sqlalchemy-trino`  

---

Connect to ClickHouse  
SQLAlchemy URI : `clickhousedb://default:default@clickhouse.clickhouse.svc.cluster.local:8123/default`

Database driver missing in superset image  
`pip install clickhouse-connect`  

---

Connect to Druid  
SQLAlchemy URI : `druid://druid-tiny-cluster-routers.druid-operator-system.svc.cluster.local:8088/druid/v2/sql`