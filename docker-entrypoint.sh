#!/bin/bash
set -e

# Make sure service is running
service rsyslog start

# Touch the log file so we can tail on it
touch /var/log/haproxy.log

# Throw the log to output
tail -f /var/log/haproxy.log &

# Create haproxy.cfg
sed -r "s/@PROJECT_NAME@/${PROJECT_NAME}/g" /etc/confd/templates/haproxy.cfg.tmpl.in > /etc/confd/templates/haproxy.cfg.tmpl
confd -onetime -backend etcd -node http://${ETCD_CLIENT_IP}:2379 --prefix="/"

# Start haproxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
