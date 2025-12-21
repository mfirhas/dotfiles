#!/bin/bash
DOMAIN="api.mfirhas.com"

mkdir -p /etc/haproxy/certs

# Combine certificates
cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem \
    /etc/letsencrypt/live/$DOMAIN/privkey.pem \
    | sudo tee /etc/haproxy/certs/api.mfirhas.com.pem > /dev/null

# Set permissions
chmod 600 /etc/haproxy/certs/$DOMAIN.pem
chown haproxy:haproxy /etc/haproxy/certs/$DOMAIN.pem

# Reload HAProxy
systemctl restart haproxy
