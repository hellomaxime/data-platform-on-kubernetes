import socket
from pyspark.sql import SparkSession
from delta import *
from pyspark.sql.functions import *

builder = SparkSession.builder\
                    .master("spark://spark-master-svc.spark.svc.cluster.local:7077")\
                    .config("spark.driver.host", socket.gethostbyname(socket.gethostname()))\
                    .config("spark.jars", "./hadoop-aws-3.3.6.jar, ./aws-java-sdk-1.12.665.jar, ./aws-java-sdk-core-1.12.665.jar, ./aws-java-sdk-s3-1.12.665.jar, ./hadoop-client-api-3.3.6.jar, ./hadoop-client-runtime-3.3.6.jar, ./delta-spark_2.12-3.1.0.jar, ./delta-storage-3.1.0.jar")\
                    .config("spark.hadoop.fs.s3a.endpoint", "http://minio.minio.svc.cluster.local:9000/")\
                    .config("spark.hadoop.fs.s3a.access.key", "admin")\
                    .config("spark.hadoop.fs.s3a.secret.key", "cdiiakMziE")\
                    .config("spark.hadoop.fs.s3a.path.style.access", "true")\
                    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")\
                    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")\
                    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")\
                    .appName('deltalake')

spark = configure_spark_with_delta_pip(builder).getOrCreate()

data = spark.range(0, 5)
data.write.format("delta").save("s3a://pyspark-deltalake/delta-table")

df = spark.read.format("delta").load("s3a://pyspark-deltalake/delta-table")
df.show()

deltaTable = DeltaTable.forPath(spark, "s3a://pyspark-deltalake/delta-table")

deltaTable.update(
  condition = expr("id % 2 == 0"),
  set = { "id": expr("id + 100") })

deltaTable.delete(condition = expr("id % 2 == 0"))

newData = spark.range(0, 20)

deltaTable.alias("oldData") \
  .merge(
    newData.alias("newData"),
    "oldData.id = newData.id") \
  .whenMatchedUpdate(set = { "id": col("newData.id") }) \
  .whenNotMatchedInsert(values = { "id": col("newData.id") }) \
  .execute()

deltaTable.toDF().show()

print("Read older versions of data using time travel")
df = spark.read.format("delta").option("versionAsOf", 0).load("s3a://pyspark-deltalake/delta-table")
df.show()

deltaTable.history().show()