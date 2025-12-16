#!/usr/bin/env bash

## vibe-scripted with chatgpt
#
# WARNING: This script must be run as root user.
# This script will create new user for deployment.
# - No password login allowed
# - Generate key-pair for deployment
# - Give access to docker commands(unsafe, but we control the user)
# - sshd configs
 
set -euo pipefail

# ======================
# MUST RUN AS ROOT
# ======================
if [[ "$(id -u)" -ne 0 ]]; then
  echo "❌ This script must be run as root"
  exit 1
fi

# ======================
# CONFIG
# ======================
APP_NAME="kartel"
MAIN_USER="mfirhas"
DEPLOY_USER="deploy"
DEPLOY_HOME="/home/${DEPLOY_USER}"
SSH_DIR="${DEPLOY_HOME}/.ssh"
KEY_NAME="github_deploy"
SUDOERS_FILE="/etc/sudoers.d/${DEPLOY_USER}"

APP_DIR="/home/${MAIN_USER}/${APP_NAME}"
APP_FILE="${APP_DIR}/docker-compose.yml"

SRC_DIR="/home/${DEPLOY_USER}/${APP_NAME}"
SRC_FILE="${SRC_DIR}/docker-compose.yml"


# ======================
# CREATE USER
# ======================
if id "${DEPLOY_USER}" &>/dev/null; then
  echo "ℹ️  User ${DEPLOY_USER} already exists"
else
  useradd \
    --create-home \
    --home-dir "${DEPLOY_HOME}" \
    --shell /bin/bash \
    --comment "GitHub Actions deployment user" \
    "${DEPLOY_USER}"
fi

# Lock password (no password login)
passwd -l "${DEPLOY_USER}"

# make deployment directory
mkdir -p "${SRC_DIR}"
chown -R "${DEPLOY_USER}:${DEPLOY_USER}" "${SRC_DIR}"
chmod 750 "${SRC_DIR}"

# ======================
# SSH KEY SETUP
# ======================
mkdir -p "${SSH_DIR}"
chmod 700 "${SSH_DIR}"

# Generate keypair (CI-only, no passphrase)
if [[ ! -f "${SSH_DIR}/${KEY_NAME}" ]]; then
  ssh-keygen \
    -t ed25519 \
    -f "${SSH_DIR}/${KEY_NAME}" \
    -N "" \
    -C "github-actions-deploy"
fi

# Authorized keys
cp "${SSH_DIR}/${KEY_NAME}.pub" "${SSH_DIR}/authorized_keys"
chmod 600 "${SSH_DIR}/authorized_keys"

# Ownership
chown -R "${DEPLOY_USER}:${DEPLOY_USER}" "${SSH_DIR}"

# ======================
# DOCKER ACCESS
# ======================
# Add ${DEPLOY_USER} user to docker group
usermod -aG docker "${DEPLOY_USER}"

# ======================
# SUDO HARDENING (OPTIONAL)
# ======================
cat > "${SUDOERS_FILE}" <<EOF
${DEPLOY_USER} ALL=(${MAIN_USER}) NOPASSWD: /usr/bin/docker
${DEPLOY_USER} ALL=(root) NOPASSWD: /bin/cp ${SRC_FILE} ${APP_FILE}
${DEPLOY_USER} ALL=(root) NOPASSWD: /bin/chown ${MAIN_USER}\:${MAIN_USER} ${APP_FILE}
${DEPLOY_USER} ALL=(root) NOPASSWD: /bin/chmod 640 ${APP_FILE}
EOF

# validate sudoers file
visudo -cf "${SUDOERS_FILE}"

chmod 440 "${SUDOERS_FILE}"

# ======================
# SSH HARDENING FOR THIS USER
# ======================
SSH_MATCH_CONF="/etc/ssh/sshd_config.d/99-${DEPLOY_USER}.conf"

cat > "${SSH_MATCH_CONF}" <<EOF
Match User ${DEPLOY_USER}
    PasswordAuthentication no
    KbdInteractiveAuthentication no
    PermitTTY no
    X11Forwarding no
    AllowTcpForwarding no
    PermitTunnel no
EOF

# Reload SSH safely
sshd -t && systemctl reload ssh

# ======================
# OUTPUT FOR GITHUB
# ======================
echo
echo "======================================"
echo "✅ DEPLOY USER READY"
echo
echo "Username: ${DEPLOY_USER}"
echo
echo "🔐 Private key (store as GitHub secret VPS_SSH_KEY):"
echo "--------------------------------------"
cat "${SSH_DIR}/${KEY_NAME}"
echo "--------------------------------------"
echo
echo "Optional (known_hosts):"
echo "ssh-keyscan -H <your-vps-ip>"
echo
echo "======================================"
