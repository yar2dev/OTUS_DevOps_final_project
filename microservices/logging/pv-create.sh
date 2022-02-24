#!/bin/bash
# create disks for cluster
yc compute disk create \
 --name data-es-cluster-0 \
 --size 10 \
 --zone "ru-central1-c" \
 --description "data-es-cluster-0"

yc compute disk create \
 --name data-es-cluster-1 \
 --size 10 \
 --zone "ru-central1-c" \
 --description "data-es-cluster-1"

 yc compute disk create \
 --name data-es-cluster-2 \
 --size 10 \
 --zone "ru-central1-c" \
 --description "data-es-cluster-2"

yc compute disk list

