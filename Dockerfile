FROM haproxy:1.7

MAINTAINER xingjiudong <25635680@qq.com>

ENV ETCD_VERSION v2.3.7
ENV CONFD_VERSION 0.11.0 

RUN apt-get update && apt-get install rsyslog wget -y --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz --no-check-certificate && \
    tar xvzf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
    rm -rf etcd-${ETCD_VERSION}-linux-amd64 && \
    rm -rf etcd-${ETCD_VERSION}-linux-amd64.tar.gz
RUN wget https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 --no-check-certificate && \
    chmod +x confd-${CONFD_VERSION}-linux-amd64 && \
    mv confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd && \
    sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf && \
    sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf

COPY ./confd /etc/confd
COPY ./haproxy.conf /etc/rsyslog.d
COPY ./docker-entrypoint.sh /

EXPOSE 27017

ENTRYPOINT ["/docker-entrypoint.sh"]
