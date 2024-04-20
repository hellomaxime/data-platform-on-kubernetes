FROM ubuntu

RUN apt update && apt install curl -y && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN apt install ssh -y && \
    service ssh restart && \
    echo "\nPermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo 'root:root' | chpasswd

EXPOSE 22/tcp