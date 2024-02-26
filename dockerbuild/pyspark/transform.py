import socket
from pyspark.sql import SparkSession

spark = SparkSession.builder\
                    .master("spark://spark-master-svc.spark.svc.cluster.local:7077")\
                    .config("spark.driver.host", socket.gethostbyname(socket.gethostname()))\
                    .config("spark.jars", "./hadoop-aws-3.3.6.jar, ./aws-java-sdk-1.12.665.jar, ./aws-java-sdk-core-1.12.665.jar, ./aws-java-sdk-s3-1.12.665.jar, ./hadoop-client-api-3.3.6.jar, ./hadoop-client-runtime-3.3.6.jar")\
                    .config("spark.hadoop.fs.s3a.endpoint", "http://minio.minio.svc.cluster.local:9000/")\
                    .config("spark.hadoop.fs.s3a.access.key", "admin")\
                    .config("spark.hadoop.fs.s3a.secret.key", "cdiiakMziE")\
                    .config("spark.hadoop.fs.s3a.path.style.access", "true")\
                    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")\
                    .appName('wordcount')\
                    .getOrCreate()
sc = spark.sparkContext

text_file = sc.textFile("s3a://pyspark-bucket/text.txt")
counts = text_file.flatMap(lambda line: line.split(" ")) \
            .map(lambda word: (word, 1)) \
            .reduceByKey(lambda x, y: x + y)

output = counts.collect()
for (word, count) in output:
    print("%s: %i" % (word, count))