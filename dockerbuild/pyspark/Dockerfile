FROM python:3.11.8-alpine3.19

WORKDIR /home/

COPY transform.py requirements.txt jars.txt ./

RUN apk update && apk add \
    openjdk11 \
    openjdk11-jre \
    bash \
    git \
    vim \
    curl \
    wget

RUN wget -i jars.txt

RUN pip install -r requirements.txt