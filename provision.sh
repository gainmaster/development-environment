#!/usr/bin/env bash

PROFILE=${1:-default}

if [ ! -d "/projects/development-environment/profile/$profile" ]; then 
    echo "Unable to find profile: $PROFILE, provisioning default profile"
    PROFILE=default
fi

# Clean up
systemctl stop development-machine
rm -rf /machine && mkdir /machine
rm -rf /volumes && mkdir /volumes

# Build development-machine
docker build -t development-machine /projects/development-environment/profile/$1
docker export "$(docker create --name development-machine development-machine true)" | tar -x -C /machine
docker rm development-machine
docker rmi development-machine

# Enable and start machine
systemctl enable development-machine
systemctl start development-machine

# Load host spesific envorinment
. <(sed '/^export/!s/^/export /' "/etc/coreos_metadata")

# Enable access to CoreOS docker
echo "Adding DOCKER_HOST to environment"
echo "DOCKER_HOST=tcp://${PUBLIC_IPV4}:2375" >> /machine/etc/environment

# Enable access to CoreOS etcdctl
echo "Adding ETCDCTL_PEERS to environment"
echo "ETCDCTL_PEERS=http://${PUBLIC_IPV4}:4001" >> /machine/etc/environment

# Enable access to CoreOS fleetctl
echo "Adding FLEETCTL_ENDPOINT to environment"
echo "FLEETCTL_ENDPOINT=http://${PUBLIC_IPV4}:4001" >> /machine/etc/environment
