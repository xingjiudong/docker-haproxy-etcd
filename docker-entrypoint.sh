#!/bin/bash
set -e

export TIMEOUT_CONNECT=${TIMEOUT_CONNECT}
export TIMEOUT_CLIENT=${TIMEOUT_CLIENT}
export TIMEOUT_SERVER=${TIMEOUT_SERVER}
export TIMEOUT_HTTP_KEEP_ALIVE=${TIMEOUT_HTTP_KEEP_ALIVE}
export MAXCONN=${MAXCONN}

# Make sure service is running
service rsyslog start

# Touch the log file so we can tail on it
touch /var/log/haproxy.log

# Throw the log to output
tail -f /var/log/haproxy.log &

# Create haproxy.cfg
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP}:2379 --prefix="/haproxy-config/${PROJECT_NAME}"

# Start haproxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
