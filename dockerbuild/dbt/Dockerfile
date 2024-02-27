FROM python:3.11.8-alpine3.19

WORKDIR /home/

COPY profiles.yml /root/.dbt/

COPY dbt_kube ./

RUN apk update && apk add \
    bash \
    git

RUN pip install dbt-postgres==1.7.8