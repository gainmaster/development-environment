#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")

## if directory is empty
sudo su
systemctl stop machine
rm -rf /machine && mkdir /machine
docker build -t machine /projects/development-environment/profile/tony
docker export "$(docker create --name machine machine true)" | tar -x -C /machine
docker rm machine
docker rmi machine
systemctl enable machine
systemctl start machine

# Load host spesific envorinment
. <(sed '/^export/!s/^/export /' "/etc/metadata")

# Enable access to CoreOS docker
echo "Adding DOCKER_HOST to /etc/environment"
echo "DOCKER_HOST=tcp://${PUBLIC_IPV4}:2376" >> /machine/etc/environment

# Enable access to CoreOS etcdctl
echo "Adding ETCDCTL_PEERS to /etc/environment"
echo "ETCDCTL_PEERS=http://${PUBLIC_IPV4}:4001" >> /machine/etc/environment

# Enable access to CoreOS fleetctl
echo "Adding FLEETCTL_ENDPOINT to /etc/environment"
echo "FLEETCTL_ENDPOINT=http://${PUBLIC_IPV4}:4001" >> /machine/etc/environment
