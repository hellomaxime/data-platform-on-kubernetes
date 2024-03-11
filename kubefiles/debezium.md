Configure Debezium MySQL connector
```
curl -H "Accept:application/json" 192.168.49.2:30500/

curl -H "Accept:application/json" 192.168.49.2:30500/connectors/

curl -i -X POST \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    192.168.49.2:30500/connectors/ \
    -d '{ 
      "name": "inventory-connector",
      "config": { 
      	      "connector.class": "io.debezium.connector.mysql.MySqlConnector", 
      	      "tasks.max": "1", 
      	      "database.hostname": "mysql-service.mysql.svc.cluster.local", 
      	      "database.port": "3306", 
      	      "database.user": "root", 
      	      "database.password": "root", 
      	      "database.server.id": "1", 
      	      "topic.prefix": "mysql", 
      	      "database.include.list": "inventory", 
      	      "schema.history.internal.kafka.bootstrap.servers": "kafka-cluster-kafka-bootstrap.kafka.svc.cluster.local:9092", 
      	      "schema.history.internal.kafka.topic": "schema.history.inventory"
     } 
}'
```