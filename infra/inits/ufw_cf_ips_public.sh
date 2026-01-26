#!/bin/bash

# Make sure to deny any incoming first.
ufw default deny incoming 

# Allow cloudflare IPv4 ranges to port 80 & 443
for ip in $(curl -s https://www.cloudflare.com/ips-v4); do
    ufw allow from "$ip" to any port 80,443 proto tcp
done

# Allow cloudflare IPv6 ranges to port 80 & 443
for ip in $(curl -s https://www.cloudflare.com/ips-v6); do
    ufw allow from "$ip" to any port 80,443 proto tcp
done

echo "Cloudflare IPs added to ufw for port 80 & 443"
