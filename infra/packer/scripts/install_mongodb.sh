#!/bin/bash
apt-get install apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update
while PID=$(pidof -s apt-get); do tail --pid=$PID -f /dev/null; done
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
