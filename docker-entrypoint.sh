#!/bin/bash
set -e

export TIMEOUT_CONNECT=${TIMEOUT_CONNECT:-5s}
export TIMEOUT_CLIENT=${TIMEOUT_CLIENT:-50s}
export TIMEOUT_SERVER=${TIMEOUT_SERVER:-50s}
export TIMEOUT_HTTP_KEEP_ALIVE=${TIMEOUT_HTTP_KEEP_ALIVE:-50s}
export MAXCONN=${MAXCONN:-2000}

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
