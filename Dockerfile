FROM ubuntu:18.04

EXPOSE 22 8123 8124 8125

COPY ["sources.list", "/etc/apt/sources.list"]

RUN apt-get update && \
    apt-get install -y openssh-server default-jdk wget htop vim coreutils && \
    apt-get autoremove -y && \
    apt-get clean

RUN mkdir -p /root/.ssh
COPY ["id_rsa.pub", "/root/.ssh/authorized_keys"]

RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

ADD http://gosspublic.alicdn.com/ossutil/1.6.10/ossutil64 /bin/ossutil64
RUN chmod 755 /bin/ossutil64
ADD https://github.com/Tiiffi/mcrcon/releases/download/v0.7.1/mcrcon-0.7.1-linux-x86-64.tar.gz /root/
RUN cp /root/mcrcon-0.7.1-linux-x86-64/mcrcon /bin/mcrcon
RUN chmod 755 /bin/mcrcon

COPY ["docker-entrypoint.sh", "/"]
RUN chmod 755 /docker-entrypoint.sh

CMD [ "/docker-entrypoint.sh" ]
