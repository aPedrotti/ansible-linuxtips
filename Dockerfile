FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y\
    ansible \
    curl \
    python3-pip \
    rsync \
    sshpass \
    unzip \
    vim \
    wget \
    && pip3 install boto \
    && wget https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_linux_amd64.zip -O /tmp/terraform_0.14.9_linux_amd64.zip \
    && unzip /tmp/terraform_0.14.9_linux_amd64.zip -d /usr/bin && rm -f /tmp/terraform_0.14.9_linux_amd64.zip \
    && apt clean 
