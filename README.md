# How to use

## Add keys to etcd (example project mongo and openldap)
- etcdctl mkdir /haproxy-config/${PROJECT_NAME}/mongo
- etcdctl mkdir /haproxy-config/${PROJECT_NAME}/openldap
- etcdctl set haproxy-config/${PROJECT_NAME}/mongo/frontend/bind *:27017
- etcdctl set haproxy-config/${PROJECT_NAME}/mongo/frontend/default_backend  mongo-server
- etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-1  mongo-1:27017
- etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-2  mongo-2:27017
- etcdctl set haproxy-config/${PROJECT_NAME}/mongo/backend/mongo-3  mongo-3:27017
- etcdctl set haproxy-config/${PROJECT_NAME}/openldap/frontend/bind *:389
- etcdctl set haproxy-config/${PROJECT_NAME}/openldap/frontend/default_backend  openldap-server
- etcdctl set haproxy-config/${PROJECT_NAME}/openldap/backend/openldap-1  openldap-1:389
- etcdctl set haproxy-config/${PROJECT_NAME}/openldap/backend/openldap-2  openldap-2:389
- etcdctl set haproxy-config/${PROJECT_NAME}/openldap/backend/openldap-3  openldap-3:389

## Create docker container 
#Add environment variable

- ETCD_CLIENT_IP  (ETCD node IP}

- PROJECT_NAME (Projects that include Mongo and OPENLDAP)

- docker run --name some-name -p 27017:27017 -p 389:389 -e ETCD_CLIENT_IP=192.168.0.1  -e PROJECT_NAME=project00 -d xingjiudong/haproxy-etcd
  
 


