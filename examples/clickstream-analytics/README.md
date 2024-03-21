This is an example to show how clickstream from a web application can be captured and displayed in Apache Superset for real-time analytics.

Stack : Webapp / Flask / Kafka / Druid / Superset

__Steps__:
- Deploy Kafka
    - create a topic "clickstream-topic"
- Deploy Postgresql
    - create a database named "druid"
- Deploy Druid
    - create a new stream to ingest data from kafka topic
- Deploy Superset
    - set a new database connection to Druid : `druid://druid-tiny-cluster-routers.druid-operator-system.svc.cluster.local:8088/druid/v2/sql`
    - create charts and dashboards
    - set auto-refresh
    - you are ready to visualize your real-time data
- Run the simple web application to generate clickstream data
    - https://github.com/hellomaxime/simple-app-for-clickstream