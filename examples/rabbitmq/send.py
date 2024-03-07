#!/usr/bin/env python
import pika

credentials = pika.PlainCredentials('default_user_igKsLlZEIp2JRvuYxkH', 'w-LiOTs8tHkQxwX3poWf_yVSBxBRBum2')
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost', credentials=credentials))
channel = connection.channel()

channel.queue_declare(queue='hello-world')

channel.basic_publish(exchange='',
                      routing_key='hello-world',
                      body='Hello World!')
print(" [x] Sent 'Hello World!'")
connection.close()