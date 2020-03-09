FROM ubuntu:18.04

EXPOSE 22 8123 8124 8125

COPY ["sources.list", "/etc/apt/sources.list"]

RUN apt-get update && \
    apt-get install -y openssh-server default-jdk && \
    apt-get autoremove -y && \
    apt-get clean

RUN useradd -ms /bin/bash lams
COPY ["lams_id_rsa.pub", "/home/lams/id_rsa.pub"]
RUN test -d /home/lams/.ssh || mkdir /home/lams/.ssh
RUN touch /home/lams/.ssh/authorized_keys
RUN echo /home/lams/id_rsa.pub >> /home/lams/.ssh/authorized_keys
RUN chmod 700 ~/.ssh
RUN chmod 600 ~/.ssh/authorized_keys
RUN chown -R lams:lams /home/lams/.ssh