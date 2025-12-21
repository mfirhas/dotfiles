#!/bin/bash

# Initialize ubuntu vps and register into tailnet.
# Run as `root`

set -euo pipefail

apt update

## Install some essentials
apt install -y \
  ca-certificates \
  curl \
  gnupg

## Install docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sleep 2
apt update

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl start docker

systemctl status docker

## Setup tailscale
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --ssh
sleep 10
tailscale ip
tailscale status
sleep 5

## Firewall
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming 
ufw default allow outgoing

ufw --force enable

echo -e "=========FINISHED INITIALIZING UBUNTU VPS========="
