#!/bin/bash

# Initialize ubuntu vps and register into tailnet.
# Run as `root`

set -euo pipefail

echo -e "===Update Packages==="
apt update
echo -e "===Finished Update Packages===\n"

## Install some essentials
echo -e "===Install Essentials==="
echo
apt install -y \
  ca-certificates \
  curl \
  gnupg
echo -e "===Finished Installing Essentials===\n"

## Install docker
echo -e "===Install & Run Docker==="
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

sleep 1

groupadd docker

systemctl start docker

systemctl status docker
echo -e "===Finished Installing & Running Docker===\n"

## Setup tailscale
echo -e "===Install & Start Tailscale==="
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --ssh
sleep 10
tailscale ip
tailscale status
sleep 5
echo -e "===Finished Installing & Starting Tailscale===\n"

## Firewall
echo -e "===Install and Start Firewall==="
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming 
ufw default allow outgoing

ufw --force enable
echo -e "===Finished Install and Start Firewall===\n"

echo -e "=========FINISHED INITIALIZING UBUNTU VPS========="
