#!/bin/bash
# WARNING: make sure to publish ssh pub key to VPS first before executing this script, otherwise you might get locked out.
# This script will initialize initial state of ubuntu VPS.
# - Create new non-root user
# - Copy root ssh keys to new non-root user
# - Change ssh default port
# - Forbid root login
# - Forbid password login
# - Allow pubkey login
# - Set default initial ufw firewall config
#
# You can execute it from local: `ssh root@ip "bash -s" < $GH/dotfiles/setup/init_ubuntu.sh`

set -euo pipefail

USERNAME=mfirhas
SSHPORT=2345

# create new non-root user as your main user interacting with your vps.
adduser ${USERNAME}

# add your newly created user to sudo group
usermod -aG sudo ${USERNAME}

# your new user home directory path
HOMEDIR=$(eval echo ~${USERNAME})

# make dir for ssh keys
mkdir -p ${HOMEDIR}/.ssh

# copy ssh keys from root to user home dir
cp /root/.ssh/authorized_keys ${HOMEDIR}/.ssh
chmod 0700 ${HOMEDIR}/.ssh
chmod 0600 ${HOMEDIR}/.ssh/authorized_keys
# change group and owner to newly created user for ssh dir
chown --recursive "${USERNAME}":"${USERNAME}" "${HOMEDIR}/.ssh"

## editing sshd config, these are idempotent
# change port to 2222
sed -i "s/^#\?Port.*/Port ${SSHPORT}/" /etc/ssh/sshd_config

# disable root login
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# disable password authentication
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# enable pubkey authentication
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config

systemctl daemon-reload
systemctl restart ssh
systemctl restart ssh.socket

ufw allow ${SSHPORT}/tcp
ufw default deny incoming 
ufw default allow outgoing

ufw enable

