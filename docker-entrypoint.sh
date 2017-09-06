#!/bin/bash
set -e

: ${ETCD_CLIENT_IP:=127.0.0.1}
: ${SERVICE:=service}

# Make sure service is running
service rsyslog start

# Touch the log file so we can tail on it
touch /var/log/haproxy.log

# Throw the log to output
tail -f /var/log/haproxy.log &

# Create haproxy.cfg
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP}:2379

# Start haproxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
