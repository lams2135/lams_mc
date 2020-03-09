FROM ubuntu:18.04

EXPOSE 22 8123 8124 8125

COPY ["sources.list", "/etc/apt/sources.list"]

RUN apt-get update && \
    apt-get install -y openssh-server default-jdk && \
    apt-get autoremove -y && \
    apt-get clean && \
    systemctl enable ssh.service

RUN mkdir -p /root/.ssh
COPY ["id_rsa.pub", "/root/.ssh/authorized_keys"]

RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
