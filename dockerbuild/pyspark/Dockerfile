FROM python:3.11.8-alpine3.19

WORKDIR /home/

COPY transform.py requirements.txt ./

RUN apk update && apk add \
    openjdk11 \
    openjdk11-jre \
    bash \
    git \
    vim \
    curl \
    wget

RUN pip install -r requirements.txt