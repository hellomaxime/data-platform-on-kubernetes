FROM ubuntu:22.04

WORKDIR /home/

COPY transform.py requirements.txt ./

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk-headless \
    openjdk-11-jre-headless \
    python3 \
    python3-pip \
    vim \
    git \
    curl

RUN pip install -r requirements.txt